//
//  QuestionOrder.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 01.12.2022.
//

import Foundation

enum QuestionOrder: Codable {
    case ordered
    case random
}

extension QuestionOrder {
    func strategyObject() -> QuestionOrderStrategy {
        switch self {
        case .ordered:
            return AscQuestionOrderStrategy()
        case .random:
            return RandomQuestionOrderStrategy()
        }
    }
}

