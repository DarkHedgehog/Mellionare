//
//  GameResult.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 29.11.2022.
//

import Foundation

struct GameResult: Codable {
    let date: Date
    let answersDone: Int
    let answersTotal: Int
    let donePercent: Int
}
