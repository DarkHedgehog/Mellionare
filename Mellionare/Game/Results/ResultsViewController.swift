//
//  ResultsViewController.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 29.11.2022.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
    }
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.shared.gameResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let result = Game.shared.gameResults[indexPath.row]
        let text = "\(dateFormatter.string(from: result.date)), \(result.answersDone)/\(result.answersTotal), \(result.donePercent)%"
        cell.textLabel?.text = text

        return cell
    }
}
