//
//  QuestionsEditViewController.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 01.12.2022.
//

import UIKit

class QuestionsEditViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    @IBAction func addQuestion(_ sender: Any) {
        let emptyQuestionRecord = GameQuestion(
            id: genQuestionId(),
            text: "",
            answers: [
                GameAnswerVariant(id: 0, text: ""),
                GameAnswerVariant(id: 1, text: ""),
                GameAnswerVariant(id: 2, text: ""),
                GameAnswerVariant(id: 3, text: "")
            ],
            correctAnswerId: 0
        )
        questions.append(emptyQuestionRecord)
        tableView.reloadData()
    }

    var questions: [GameQuestion] = []

    private var questionIdGen = 0;

    override func viewDidLoad() {
        super.viewDidLoad()

        questionIdGen = Game.shared.questionCustomData.map { $0.id }.max() ?? 0
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
    }

    private func genQuestionId() -> Int {
        questionIdGen += 1
        return questionIdGen
    }
}

extension QuestionsEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(280)
    }
}

extension QuestionsEditViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionEditViewCell", for: indexPath)
                as? QuestionEditViewCell else {
            preconditionFailure("Error cast to AnswerTableViewCell")
        }

        let question = questions[indexPath.row]
        cell.questionText.text = question.text
        let answersStrings = question.answers.map { $0.text }
        cell.answersVariations.prepareElements(answersStrings, selectedIndex: question.correctAnswerId)
        return cell
    }
}
