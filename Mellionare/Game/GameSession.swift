//
//  GameSession.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 26.11.2022.
//

import Foundation

protocol GameSessionDelegate: AnyObject {
    func checkAnswer(id: Int) -> Bool
    func resolveQuestion()
    func useHint(hint: GameHints) -> Bool
    func getQuestion() -> GameQuestion
    func getProgressObservable() -> Observable<Int>
    func questionsCount() -> Int
}

class GameSession {
    var availableHints: [GameHints] = []
    var correctAnswersCount: Observable<Int>
    var currentQuestionIndex = 0
    var currentQuestion: GameQuestion { gameQuestions[currentQuestionIndex] } 
    var gameQuestions: [GameQuestion] = []
    var questionOrderStrategy: QuestionOrderStrategy
    var resolveQuestionsIndexes: [Int] = []
    var friendHelpForQuestion: Int?
    var friendHelpAnswer: Int?

    init (stratege: QuestionOrderStrategy) {
        gameQuestions = gameQuestionsData
        questionOrderStrategy = stratege
        availableHints = [.helpOfHall, .halfOfVariants, .callToFriend]
        correctAnswersCount = Observable(0)
        setNextQuestion()
    }

    private func setNextQuestion() {
        let availableQuestions = gameQuestions.filter { $0.isResolved == false }
        let nextQuestionId = questionOrderStrategy.nextQuestionId(questions: availableQuestions)
        currentQuestionIndex = gameQuestions.firstIndex { $0.id == nextQuestionId } ?? 0
    }
}

extension GameSession: GameSessionDelegate {
    func getQuestion() -> GameQuestion {
        return currentQuestion
    }

    func questionsCount() -> Int {
        return gameQuestions.count
    }

    func resolveQuestion() {
        correctAnswersCount.value += 1
        gameQuestions[currentQuestionIndex].isResolved = true
        setNextQuestion()
    }

    func checkAnswer(id: Int) -> Bool {
        return id == gameQuestions[currentQuestionIndex].correctAnswerId
    }

    func getProgressObservable() -> Observable<Int> {
        return correctAnswersCount
    }

    func useHint(hint: GameHints) -> Bool {
        guard let indexOfAvailable = availableHints.firstIndex(of: hint) else { return false }

        availableHints.remove(at: indexOfAvailable)

        switch hint {
        case .callToFriend:
            friendHelpForQuestion = currentQuestionIndex
            let availableAnswers = currentQuestion.answers.filter { $0.isEnabled }
            friendHelpAnswer = availableAnswers[Int.random(in: 0..<availableAnswers.count)].id
        case .halfOfVariants:
            for _ in 0..<Int(currentQuestion.answers.count / 2) {
                var incorrectAnswers = currentQuestion.answers.filter {
                    $0.isEnabled && ($0.id != currentQuestion.correctAnswerId)
                }
                incorrectAnswers[Int.random(in: 0..<incorrectAnswers.count)].isEnabled = false
            }
        case .helpOfHall:
            var totalChance = 100
            for i in 0..<Int(currentQuestion.answers.count - 1) {
                let vote = Int.random(in: 0...totalChance)
                totalChance -= vote
                gameQuestions[currentQuestionIndex].answers[i].hallVote = vote
            }
            gameQuestions[currentQuestionIndex].answers[currentQuestion.answers.count].hallVote = totalChance
        }

        return true
    }
}
