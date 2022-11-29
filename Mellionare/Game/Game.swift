//
//  Game.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 26.11.2022.
//

import Foundation

class Game {

    static let shared = Game()

    private(set) var gameResults: [GameResult] = []

    var currentSession: GameSession?


    private init() {
    }

    func startNewSession() {
        currentSession = GameSession()
    }

    func endSession() {
        guard let session = currentSession else { return }

        let result = GameResult(date: Date(),
                                answersDone: session.correctAnswersCount,
                                answersTotal: session.gameData.count,
                                donePercent: Int(100 * session.correctAnswersCount / session.gameData.count ))

        addResult(result)

        currentSession = nil;
    }

    func addResult(_ result: GameResult) {
        gameResults.append(result)
    }

    func clearResults() {
        gameResults = []
    }

}
