//
//  AscQuestionOrderStrategy.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 01.12.2022.
//

import Foundation


class AscQuestionOrderStrategy: QuestionOrderStrategy {
    func nextQuestionId(questions: [GameQuestion]) -> Int {
        guard questions.count >= 1 else {
            return 0
        }
        return questions[0].id
    }
}
