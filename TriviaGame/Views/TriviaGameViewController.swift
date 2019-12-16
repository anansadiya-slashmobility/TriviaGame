//
//  TriviaGameViewController.swift
//  TriviaGame
//
//  Created by Anan Sadiya on 15/12/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import UIKit

protocol TriviaGameInterface {
    func showLoading()
    func hideLoading()
    func showAlert(alertTitle: String, alertMessage: String, alertActionTitle: String, alertType: AlertType)
}

class TriviaGameViewController: UIViewController {
    let triviaGamePresenter = TriviaGamePresenter()
    var questions: [Question] = []
    var firstPlayer: Player = Player()
    var secondPlayer: Player = Player()
    var currentPlayer: Player = Player()
    var correctAnswer: String = ""
    var questionNumber: Int = 0
    @IBOutlet weak var firstPlayerNickNameLabel: UILabel!
    @IBOutlet weak var firstPlayerScoreLabel: UILabel!
    @IBOutlet weak var secondPlayerNickNameLabel: UILabel!
    @IBOutlet weak var secondPlayerScoreLabel: UILabel!
    @IBOutlet weak var currentPlayerLabel: UILabel!
    @IBOutlet weak var currentPlayerNickNameLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstAnswerButton: UIButton!
    @IBOutlet weak var secondAnswerButton: UIButton!
    @IBOutlet weak var thirdAnswerButton: UIButton!
    @IBOutlet weak var fourthAnswerButton: UIButton!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        triviaGamePresenter.attachView(view: self)
        configureData()
        configureUI()
    }
    
    // MARK: UI management
    private func configureUI() {
        setNavigationController()
        setUI()
    }
    
    private func setNavigationController() {
        self.navigationItem.title = NaviagtionControllerTexts.title
        self.navigationController!.navigationBar.topItem!.title = NaviagtionControllerTexts.backTitle
    }
    
    private func setUI() {
        firstPlayerNickNameLabel.text = firstPlayer.nickName
        firstPlayerScoreLabel.text = String(firstPlayer.score)
        secondPlayerNickNameLabel.text = secondPlayer.nickName
        secondPlayerScoreLabel.text = String(secondPlayer.score)
        setCurrentPlayer()
    }
    
    private func setCurrentPlayer() {
        currentPlayerLabel.text = TriviaGameScreenTexts.currentPlayerLabelText
        if questionNumber % 2 == 0 {
            currentPlayer.nickName = firstPlayer.nickName
        } else {
            currentPlayer.nickName = secondPlayer.nickName
        }
        currentPlayerNickNameLabel.text = currentPlayer.nickName
    }
    
    func hideQuestionLabel(hide: Bool) {
        questionLabel.isHidden = hide
    }
    
    private func setAnswers() {
        var answers: [String] = []
        answers.append(questions[questionNumber].correctAnswer)
        answers.append(contentsOf: questions[questionNumber].incorrectAnswers)
        answers = answers.shuffled()
        setAnswersButtons(answers: answers)
        hideAnswersButtons(hide: false)
    }
    
    private func setAnswersButtons(answers: [String]) {
        setFirstAnswerButon(answers[0])
        setSecondAnswerButon(answers[1])
        setThirdAnswerButon(answers[2])
        setFourthAnswerButon(answers[3])
    }
    
    private func setFirstAnswerButon(_ answer: String) {
        firstAnswerButton.setTitle(answer, for: .normal)
        firstAnswerButton.layer.cornerRadius = 10
        firstAnswerButton.layer.borderWidth = 1
        firstAnswerButton.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setSecondAnswerButon(_ answer: String) {
        secondAnswerButton.setTitle(answer, for: .normal)
        secondAnswerButton.layer.cornerRadius = 10
        secondAnswerButton.layer.borderWidth = 1
        secondAnswerButton.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setThirdAnswerButon(_ answer: String) {
        thirdAnswerButton.setTitle(answer, for: .normal)
        thirdAnswerButton.layer.cornerRadius = 10
        thirdAnswerButton.layer.borderWidth = 1
        thirdAnswerButton.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setFourthAnswerButon(_ answer: String) {
        fourthAnswerButton.setTitle(answer, for: .normal)
        fourthAnswerButton.layer.cornerRadius = 10
        fourthAnswerButton.layer.borderWidth = 1
        fourthAnswerButton.layer.borderColor = UIColor.white.cgColor
    }
    
    func hideAnswersButtons(hide: Bool) {
        firstAnswerButton.isHidden = hide
        secondAnswerButton.isHidden = hide
        thirdAnswerButton.isHidden = hide
        fourthAnswerButton.isHidden = hide
    }
    
    private func increaseScore() {
        if currentPlayer.nickName == firstPlayer.nickName {
            firstPlayer.score += 1
        } else if currentPlayer.nickName == secondPlayer.nickName {
            secondPlayer.score += 1
        }
        setUI()
    }
    
    private func gameFinished() {
        var gameFinishedMessage: String = ""
        if firstPlayer.score > secondPlayer.score {
            gameFinishedMessage = GameFinished.winnerMessage + firstPlayer.nickName
        } else if secondPlayer.score > firstPlayer.score {
            gameFinishedMessage = GameFinished.winnerMessage + secondPlayer.nickName
        } else {
            gameFinishedMessage = GameFinished.drawMessage
        }
        showAlert(alertTitle: GameFinished.title, alertMessage: gameFinishedMessage, alertActionTitle: GameFinished.action, alertType: .gameFinished)
    }
    
    private func newGame() {
        firstPlayer.score = 0
        secondPlayer.score = 0
        questionNumber = 0
        setUI()
        triviaGamePresenter.fetchData()
    }
    
    // MARK: Configure Data
    func configureData() {
        getQuestions()
    }
    
    private func getQuestions() {
        triviaGamePresenter.fetchData()
    }
    
    func setTrivia() {
        if questionNumber < API.questionsNumber {
            setQuestion()
            setAnswers()
        } else {
            gameFinished()
        }
        spinner.stopAnimating()
    }
    
    func setQuestion() {
        questionLabel.text = questions[questionNumber].question.convertSpecialCharacters(string: questions[questionNumber].question)
        correctAnswer = questions[questionNumber].correctAnswer
        hideQuestionLabel(hide: false)
    }
    
    
    // MARK: UI events management
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            if buttonTitle == correctAnswer {
                showAlert(alertTitle: CorrectAnswer.title, alertMessage: CorrectAnswer.message, alertActionTitle: CorrectAnswer.action, alertType: .currectAnswer)
            } else {
                showAlert(alertTitle: WrongAnswer.title, alertMessage: WrongAnswer.message, alertActionTitle: WrongAnswer.action, alertType: .wrongtAnswer)
            }
        }
    }
}

extension TriviaGameViewController: TriviaGameInterface {
    func showLoading() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func hideLoading() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    
    func showAlert(alertTitle: String, alertMessage: String, alertActionTitle: String, alertType: AlertType) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: { action in
            switch alertType {
            case .emptyError, .networkError:
                self.triviaGamePresenter.fetchData()
            case .currectAnswer:
                self.increaseScore()
                self.questionNumber += 1
                self.setTrivia()
                self.setCurrentPlayer()
            case .wrongtAnswer:
                self.questionNumber += 1
                self.setTrivia()
                self.setCurrentPlayer()
            case .gameFinished:
                self.newGame()
            }
        }))
        self.present(alert, animated: true)
    }
}
