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
            resultsCaretaker.saveResults(gameResults)
        }
    }

    private(set) var gameSettings: GameSettings

    private let resultsCaretaker = ResultsCaretacker()
    private let settingsCaretaker = SettingsCaretacker()

    // MARK: - Properties
    var currentSession: GameSession?

    // MARK: - Constructors
    private init() {
        gameResults = resultsCaretaker.loadResults()
        gameSettings = settingsCaretaker.loadSettings()
    }

    // MARK: - Functions
    func startNewSession() {
        let selectedStratege = gameSettings.questionOrder.strategyObject()
        currentSession = GameSession(stratege: selectedStratege)
    }

    func endSession() {
        guard let session = currentSession else {
            return
        }

        let result = GameResult(
            date: Date(),
            answersDone: session.correctAnswersCount,
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
        settingsCaretaker.saveSettings(gameSettings)
    }
}
