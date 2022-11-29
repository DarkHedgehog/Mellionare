//
//  GameQuestion.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 29.11.2022.
//

import Foundation

struct GameQuestion {
    var id: Int
    /// Text of question
    var text: String
    /// Variants of answers
    var answers: [GameAnswerVariant]
    var correctAnswerId: Int
}
