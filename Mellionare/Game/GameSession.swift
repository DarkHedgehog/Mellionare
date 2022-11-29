//
//  GameSession.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 26.11.2022.
//

import Foundation

protocol GameSessionDelegate: AnyObject {
    func checkAnswer(id: Int) -> Bool
    func nextQuestion() -> Void
    func useHint(hint: GameHints) -> Bool
    func getQuestion() -> GameQuestion
}

class GameSession {

    var availableHints: [GameHints] = []
    var correctAnswersCount = 0
    var currentQuestionIndex = 0
    var currentQuestion: GameQuestion
    var gameData: [GameQuestion] = []
    var friendHelpForQuestion: Int? = nil
    var friendHelpAnswer: Int? = nil

    init () {
        gameData = GameData
        availableHints = [.helpOfHall, .halfOfVariants, .callToFriend]
        currentQuestionIndex = 0
        correctAnswersCount = 0
        currentQuestion = gameData[currentQuestionIndex]
    }
}

extension GameSession: GameSessionDelegate {

    func getQuestion() -> GameQuestion {
        return currentQuestion;
    }

    func nextQuestion() {
        correctAnswersCount += 1
        currentQuestionIndex += 1
        currentQuestion = gameData[currentQuestionIndex]
    }

    func checkAnswer(id: Int) -> Bool {
        return id == gameData[currentQuestionIndex].correctAnswerId
    }

    func useHint(hint: GameHints) -> Bool {
        guard let indexOfAvailable = availableHints.firstIndex(of: hint) else { return false }

        availableHints.remove(at: indexOfAvailable)

        switch hint {
        case .callToFriend:
            friendHelpForQuestion = currentQuestionIndex
            let availableAnswers = currentQuestion.answers.filter {$0.isEnabled}
            friendHelpAnswer = availableAnswers[Int.random(in: 0..<availableAnswers.count)].id
        case .halfOfVariants:
            for _ in 0..<Int(currentQuestion.answers.count / 2) {
                var incorrectAnswers = currentQuestion.answers.filter {$0.isEnabled && $0.id != currentQuestion.correctAnswerId}
                incorrectAnswers[Int.random(in: 0..<incorrectAnswers.count)].isEnabled = false
            }
        case .helpOfHall:
            var totalChance = 100
            for i in 0..<Int(currentQuestion.answers.count - 1) {
                let vote = Int.random(in: 0...totalChance)
                totalChance -= vote
                currentQuestion.answers[i].hallVote = vote
            }
            currentQuestion.answers[currentQuestion.answers.count].hallVote = totalChance
        }

        return true
    }   

}

