//
//  GameAnswerVariant.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 29.11.2022.
//

import Foundation

struct GameAnswerVariant: Codable {
    var id: Int
    var text: String

    /// May be disabled by hint "Call to friend"
    var isEnabled = true

    /// Percent for hint "Help by Hall"
    var hallVote: Int? = nil

    private enum CodingKeys: String, CodingKey {
        case id, text
    }

}
