//
//  GameData.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 26.11.2022.
//

import Foundation

var gameQuestionsData: [GameQuestion] = [
    GameQuestion(
        id: 0,
        text: "Каково значение фразы 'Волосы становятся дыбом'?",
        answers: [
            GameAnswerVariant(id: 0, text: "Неудачная прическа"),
            GameAnswerVariant(id: 1, text: "Крайняя степень удивления"),
            GameAnswerVariant(id: 2, text: "Крайняя степень ужаса"),
            GameAnswerVariant(id: 3, text: "Сильный ветер")
        ],
        correctAnswerId: 2
    ),
    GameQuestion(
        id: 1,
        text: "Кто стал первым человеком, ступившим на поверхность луны",
        answers: [
            GameAnswerVariant(id: 0, text: "Дюк Нюкем"),
            GameAnswerVariant(id: 1, text: "Нил Армстронг"),
            GameAnswerVariant(id: 2, text: "Чарльз Дьюк"),
            GameAnswerVariant(id: 3, text: "Роберт Бенкен")
        ],
        correctAnswerId: 1
    ),
    GameQuestion(
        id: 2,
        text: "Как писать правильно?",
        answers: [
            GameAnswerVariant(id: 0, text: "Агрессея"),
            GameAnswerVariant(id: 1, text: "Агресия"),
            GameAnswerVariant(id: 2, text: "Огресия"),
            GameAnswerVariant(id: 3, text: "Агрессия")
        ],
        correctAnswerId: 3
    ),
    GameQuestion(
        id: 3,
        text: "На берегах какой реки расположен город Красноярск",
        answers: [
            GameAnswerVariant(id: 0, text: "Ангары"),
            GameAnswerVariant(id: 1, text: "Мамайки"),
            GameAnswerVariant(id: 2, text: "Оки"),
            GameAnswerVariant(id: 3, text: "Енисея")
        ],
        correctAnswerId: 3
    ),
    GameQuestion(
        id: 4,
        text: "Какой диапазон женских голосов самый высокий?",
        answers: [
            GameAnswerVariant(id: 0, text: "Сопрано"),
            GameAnswerVariant(id: 1, text: "Меццо-сопрано"),
            GameAnswerVariant(id: 2, text: "Контральто"),
            GameAnswerVariant(id: 3, text: "Бас")
        ],
        correctAnswerId: 0
    )
]
