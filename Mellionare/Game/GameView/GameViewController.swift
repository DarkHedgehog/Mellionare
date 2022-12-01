//
//  GameViewController.swift
//  Mellionare
//
//  Created by Aleksandr Derevenskih on 26.11.2022.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answersTable: UITableView!
    @IBOutlet weak var progressLabel: UILabel!

    var gameSession: GameSessionDelegate?
    weak var gameControllerDelegate: GameControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        progressLabel.text = ""
        answersTable.delegate = self
        answersTable.dataSource = self
        gameSession = Game.shared.currentSession
        gameSession?.getProgressObservable().addObserver(self, options: [.initial, .new]) { value, _ in
            let totalCount = self.gameSession?.questionsCount() ?? 1
            let percents = 100 * value / totalCount
            let labelText = "Ответы: \(value) of \(totalCount)  (\(percents)% до победы)"
            self.progressLabel.text = labelText
        }

        updateSessionData()
    }

    func updateSessionData() {
        let question = gameSession?.getQuestion()
        questionLabel.text = question?.text
        answersTable.reloadData()
    }
    func close() {
        dismiss(animated: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        gameSession?.getProgressObservable().removeObserver(self)
        super.viewDidDisappear(animated)
    }
}


// MARK: - UITableViewDataSource - Buttons for answers
extension GameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let question = gameSession?.getQuestion()
        return question?.answers.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let question = gameSession?.getQuestion(),
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableViewCell", for: indexPath)
                as? AnswerTableViewCell else {
            preconditionFailure("Error cast to AnswerTableViewCell")
        }

        cell.answerText?.text = question.answers[indexPath.row].text
        cell.tag = question.answers[indexPath.row].id

        return cell
    }
}

// MARK: - UITableViewDelegate - Buttons
extension GameViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath),
            let gameSession = gameSession
        else {
            return
        }

        let answerId = cell.tag
        let isCorrect = gameSession.checkAnswer(id: answerId)

        if isCorrect {
            gameSession.resolveQuestion()
            updateSessionData()
        } else {
            let gameOverMessage = UIAlertController(title: "Game over", message: "Wrong answer", preferredStyle: .alert)
            gameOverMessage.addAction(
                UIAlertAction(title: "OK", style: .default) { _ in
                    self.gameControllerDelegate?.didEndGame()
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            self.present(gameOverMessage, animated: true)
        }
    }
}
