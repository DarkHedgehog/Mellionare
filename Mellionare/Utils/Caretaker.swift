//
//  Caretaker.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 04.12.2022.
//

import Foundation

class Caretacker<Type: Codable> {
    typealias Memento = Data

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key: String // = "MellionareResults"

    init(key: String) {
        self.key = key
    }

    func saveState(_ results: Type) {
        do {
            let data: Memento = try encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadState() -> Type? {
        guard let data = UserDefaults.standard.value(forKey: key) as? Memento else {
            return nil
        }

        do {
            return try decoder.decode(Type.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
