//
//  QuestionsEditViewController.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 01.12.2022.
//

import UIKit

class QuestionsEditViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Public Properties
    var questions: [GameQuestion] = []
    var questionsBuilder = QuestionsBuilder()


    // MARK: - Private Properties
    private var questionIdGen = 0

    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()

        questionIdGen = Game.shared.questionCustomData.map { $0.id }.max() ?? 0
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
    }

    // MARK: - IBAction
    @IBAction func addQuestion(_ sender: Any) {
        let qId = genQuestionId()
        questionsBuilder.addQuestion(id: qId, text: "Вопрос \(qId)")

        for i in 0..<4 {
            questionsBuilder.addAnswerVariant(id: qId, answerId: i, text: "Вариант \(i + 1)")
        }
        questionsBuilder.addCorrectAnswerId(id: qId, answerId: 0)
        questions = questionsBuilder.build()

        tableView.reloadData()
    }

    // MARK: - Private Methods
    private func genQuestionId() -> Int {
        questionIdGen += 1
        return questionIdGen
    }
}

extension QuestionsEditViewController: RadioViewDelegate {
    func switchChanged(sender: RadioView, index: Int) {
        let qId = sender.tag
        questionsBuilder.addCorrectAnswerId(id: qId, answerId: index)
    }

    func textChanged(sender: RadioView, index: Int, text: String) {
        let qId = sender.tag
        questionsBuilder.addAnswerVariant(id: qId, answerId: index, text: text)
    }
}

extension QuestionsEditViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let qId = textField.tag
        questionsBuilder.addQuestion(id: qId, text: textField.text ?? "")
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
        cell.questionText.tag = question.id
        cell.questionText.delegate = self

        let answersStrings = question.answers.map { $0.text }
        cell.answersVariations.tag = question.id
        cell.answersVariations.delegate = self
        cell.answersVariations.selectedIndex = question.correctAnswerId
        cell.answersVariations.prepareElements(answersStrings, selectedIndex: question.correctAnswerId)

        return cell
    }
}

