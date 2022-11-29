//
//  ViewController.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 26.11.2022.
//

import UIKit

class MainMenuViewController: UIViewController {
    @IBOutlet var startGameButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameStartSeque" {
            guard let destination = segue.destination as? GameViewController else { return }

            destination.gameControllerDelegate = self
            Game.shared.startNewSession()
        }
    }
}

extension MainMenuViewController: GameControllerDelegate {
    func didEndGame() {
        Game.shared.endSession()
    }
}
