//
//  Constants.swift
//  TriviaGame
//
//  Created by Anan Sadiya on 16/12/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import Foundation

struct PlayerConstants {
    static let firstPlayer = "Player 1"
    static let secondPlayer = "Player 2"
}
struct ViewControllersIdentifiers {
    static let triviaGame = "TriviaGameViewController"
}

struct API {
    static let mapAtKeyPath = "results"
    static let questionsNumber = 20
}

struct EmptyData {
    static let title = "No questions received!"
    static let message = "Unable to load questions because the server sent no data. Sorry for the inconvenience."
    static let action = "Try again"
}

struct NetworkError {
    static let title = "Network error!"
    static let message = "A network error occured. Sorry for the inconvenience."
    static let action = "Try again"
}

struct CorrectAnswer {
    static let title = "CORRECT ANSWER"
    static let message = ""
    static let action = "Next"
}

struct WrongAnswer {
    static let title = "WRONG ANSWER"
    static let message = ""
    static let action = "Next"
}

struct GameFinished {
    static let title = "Game finished!"
    static let winnerMessage = "The winner is: "
    static let drawMessage = "Draw. Play again to see who is the best"
    static let action = "Play again"
}

struct NaviagtionControllerTexts {
    static let title = "Trivia Game"
    static let backTitle = "Start over"
}

struct WelcomeScreenTexts {
    static let welcomeLabelText = "Welcome to our trivia game"
    static let firstNickNameLabelText = "Please enter the first player nickname:"
    static let firstNickNamePlaceHolderText = "Bob"
    static let secondNickNameLabelText = "Please enter the second player nickname:"
    static let secondickNamePlaceHolderText = "Fanny"
    static let playButtonTitle = "Play"
}

struct TriviaGameScreenTexts {
    static let currentPlayerLabelText = "It's your turn =>"
}

