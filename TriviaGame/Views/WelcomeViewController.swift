//
//  ViewController.swift
//  TriviaGame
//
//  Created by Anan Sadiya on 15/12/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    let welcomePresenter = WelcomePresenter()
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var firstPlayerLabel: UILabel!
    @IBOutlet weak var firstPlayerTextField: UITextField!
    @IBOutlet weak var secondPlayerLabel: UILabel!
    @IBOutlet weak var secondPlayerTextField: UITextField!
    @IBOutlet weak var playButton: UIButton!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomePresenter.attachView(view: self)
    }
        
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
     }
    
    // MARK: UI management
    private func configureUI() {
        setNavigationController()
        setUI()
    }
    private func setNavigationController() {
        self.navigationItem.title = NaviagtionControllerTexts.title
    }
    
    private func setUI() {
        setLabels()
        setPlacHolders()
        setButton()
    }
    
    private func setLabels() {
        welcomeLabel.text = WelcomeScreenTexts.welcomeLabelText
        firstPlayerLabel.text = WelcomeScreenTexts.firstNickNameLabelText
        secondPlayerLabel.text = WelcomeScreenTexts.secondNickNameLabelText
    }
    
    private func setPlacHolders() {
        firstPlayerTextField.placeholder = WelcomeScreenTexts.firstNickNamePlaceHolderText
        secondPlayerTextField.placeholder = WelcomeScreenTexts.secondickNamePlaceHolderText
    }
    
    private func setButton() {
        playButton.setTitle(WelcomeScreenTexts.playButtonTitle, for: .normal)
        playButton.layer.cornerRadius = 10
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor.white.cgColor
    }
    
    // MARK: UI events management
    @IBAction func playButtonTapped(_ sender: Any) {
        let firstPlayer = setPlayer(firstPlayerTextField, .firstPlayer)
        let secondPlayer = setPlayer(secondPlayerTextField, .secondPlayer)
        welcomePresenter.playButtonTapped(firstPlayer, secondPlayer)
    }
    
    private func setPlayer(_ textField: UITextField, _ playerType: PlayerType) -> Player {
        let player = Player()
        if let playerNickName = textField.text, playerNickName.isEmpty {
            switch playerType {
            case .firstPlayer:
                player.nickName = PlayerConstants.firstPlayer
            case .secondPlayer:
                player.nickName = PlayerConstants.secondPlayer
            }
        } else {
            player.nickName = textField.text!
        }
        return player
    }
}
