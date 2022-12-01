//
//  GameCaretacker.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 29.11.2022.
//

import Foundation


class ResultsCaretacker {
    typealias Memento = Data

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "MellionareResults"

    func saveResults(_ results: [GameResult]) {
        do {
            let data: Memento = try encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadResults() -> [GameResult] {
        guard let data = UserDefaults.standard.value(forKey: key) as? Memento else {
            return []
        }

        do {
            return try decoder.decode([GameResult].self, from: data)            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
