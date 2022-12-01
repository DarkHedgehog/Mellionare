//
//  QuestionsEditViewController.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 01.12.2022.
//

import UIKit

class QuestionsEditViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
    }
}

extension QuestionsEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(280)
    }
}
extension QuestionsEditViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionEditViewCell", for: indexPath)
                as? QuestionEditViewCell else {
            preconditionFailure("Error cast to AnswerTableViewCell")
        }

        cell.questionText.text = ""
        cell.answersVariations.prepareElements(["", "", "", ""], selectedIndex: 1)
        return cell
    }
}
