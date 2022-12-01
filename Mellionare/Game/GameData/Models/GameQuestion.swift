//
//  GameQuestion.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 29.11.2022.
//

import Foundation

struct GameQuestion: Codable {
    var id: Int
    /// Text of question
    var text: String
    /// Variants of answers
    var answers: [GameAnswerVariant]
    var correctAnswerId: Int

    /// session flag
    var isResolved = false

    init(id: Int, text: String, answers: [GameAnswerVariant], correctAnswerId: Int) {
        self.id = id
        self.text = text
        self.answers = answers
        self.correctAnswerId = correctAnswerId
    }

    private enum CodingKeys: String, CodingKey {
        case id, text, answers, correctAnswerId
    }
}
