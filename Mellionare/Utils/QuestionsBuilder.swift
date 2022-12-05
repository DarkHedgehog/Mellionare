//
//  QuestionsBuilder.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 05.12.2022.
//

import Foundation

class QuestionsBuilder {

    private var questions: Dictionary<Int, GameQuestion> = [:]

    func build() -> [GameQuestion] {
        return questions.values.compactMap { $0 }
    }

    func addQuestion (id: Int, text: String) {
        if questions[id] != nil {
            questions[id]?.text = text
        } else {
            questions[id] = GameQuestion(id: id, text: text, answers: [], correctAnswerId: -1)
        }
    }

    func addCorrectAnswerId (id: Int, answerId: Int) {
        if questions[id] == nil {
            questions[id] = GameQuestion(id: id, text: "", answers: [], correctAnswerId: answerId)
        }
        questions[id]?.correctAnswerId = answerId
    }

    func addAnswerVariant (id: Int, answerId: Int, text: String) {
        if var question = questions[id] {
            if var answerIndex = questions[id]?.answers.firstIndex {$0.id == answerId} {
                questions[id]?.answers[answerIndex].text = text
            } else {
                questions[id]?.answers.append(GameAnswerVariant(id: answerId, text: text))
            }
        } else {
            questions[id] = GameQuestion(id: id, text: "", answers: [], correctAnswerId: answerId)
            addAnswerVariant(id: id, answerId: answerId, text: text)
        }
    }
}
