//
//  Game.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 26.11.2022.
//

import Foundation

class Game {
    static let shared = Game()

    // MARK: - private properties
    private(set) var gameResults: [GameResult] {
        didSet {
            resultsCaretaker.saveState(gameResults)
        }
    }


    private(set) var gameSettings: GameSettings

    private let resultsCaretaker = Caretacker<[GameResult]>(key: "MellionareResults")
    private let settingsCaretaker = Caretacker<GameSettings>(key: "MellionareSettings")
    private let questionsCaretaker = Caretacker<[GameQuestion]>(key: "CustomQuestions")

    // MARK: - Properties
    var currentSession: GameSession?
    var questionData = gameQuestionsData
    var questionCustomData: [GameQuestion] {
        didSet {
            questionsCaretaker.saveState(questionCustomData)
        }
    }

    // MARK: - Constructors
    private init() {
        gameResults = resultsCaretaker.loadState() ?? []
        gameSettings = settingsCaretaker.loadState() ?? GameSettings(questionOrder: .ordered)
        questionCustomData = questionsCaretaker.loadState() ?? []
    }

    // MARK: - Functions
    func startNewSession() {
        let selectedStratege = gameSettings.questionOrder.strategyObject()
        var questions: [GameQuestion] = []
        questions.append(contentsOf: questionData)
        questions.append(contentsOf: questionCustomData)
        currentSession = GameSession(stratege: selectedStratege, questions: questions)
    }

    func endSession() {
        guard let session = currentSession else {
            return
        }

        let result = GameResult(
            date: Date(),
            answersDone: session.correctAnswersCount.value,
            answersTotal: session.gameQuestions.count
        )

        addResult(result)
        currentSession = nil
    }

    func addResult(_ result: GameResult) {
        gameResults.append(result)
    }

    func clearResults() {
        gameResults = []
    }

    func applySettings() {
        settingsCaretaker.saveState(gameSettings)
    }
}
