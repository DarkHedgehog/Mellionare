//
//  gameControllerDelegate.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 28.11.2022.
//

import Foundation

protocol GameControllerDelegate: AnyObject {
    func didEndGame() -> Void
}
