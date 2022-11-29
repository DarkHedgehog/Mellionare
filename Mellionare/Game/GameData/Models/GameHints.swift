//
//  GameHints.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 26.11.2022.
//

import Foundation

enum GameHints {
    case callToFriend
    case halfOfVariants
    case helpOfHall
}

extension GameHints {
    func text() -> String {
        switch (self) {
        case .callToFriend: return "Звонок другу"
        case .halfOfVariants: return "50:50"
        case .helpOfHall: return "Помощь зала"
        }
    }
}
