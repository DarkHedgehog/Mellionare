//
//  GameSettings.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 01.12.2022.
//

import Foundation

class GameSettings: Codable {
    var questionOrder: QuestionOrder = .ordered

    init(questionOrder: QuestionOrder) {
        self.questionOrder = questionOrder
    }
}
