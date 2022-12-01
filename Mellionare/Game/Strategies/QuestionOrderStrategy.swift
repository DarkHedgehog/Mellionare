//
//  QuestionOrderStrategy.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 01.12.2022.
//

import Foundation

protocol QuestionOrderStrategy {
    func nextQuestionId(questions: [GameQuestion]) -> Int
}
