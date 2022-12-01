//
//  SettingsTableViewController.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 01.12.2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var questionStratege: UISegmentedControl!

    var settings: GameSettings = Game.shared.gameSettings

    override func viewDidLoad() {
        super.viewDidLoad()

        switch settings.questionOrder {
        case .ordered:
            questionStratege.selectedSegmentIndex = 0
        case .random:
            questionStratege.selectedSegmentIndex = 1
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    // MARK: - Actions
    @IBAction func questionOrderChanged(_ sender: Any) {
        settings.questionOrder = questionStratege.selectedSegmentIndex == 1 ? .random : .ordered
        Game.shared.applySettings()
    }
}
