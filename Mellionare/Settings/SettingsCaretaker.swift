//
//  SettingsCaretaker.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 01.12.2022.
//

import Foundation

class SettingsCaretacker {
    typealias Memento = Data

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "MellionareSettings"
    private lazy var defaultSettings = GameSettings(questionOrder: .ordered)

    func saveSettings(_ settings: GameSettings) {
        do {
            let data: Memento = try encoder.encode(settings)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadSettings() -> GameSettings {
        guard let data = UserDefaults.standard.value(forKey: key) as? Memento else {
            return defaultSettings
        }

        do {
            return try decoder.decode(GameSettings.self, from: data)
        } catch {
            print(error.localizedDescription)
            return defaultSettings
        }
    }
}
