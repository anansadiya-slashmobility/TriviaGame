//
//  WelcomePresenter.swift
//  TriviaGame
//
//  Created by Anan Sadiya on 15/12/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import Foundation

class WelcomePresenter {
    var view: WelcomeViewController!
    
    func attachView(view: WelcomeViewController) {
        self.view = view
    }
    
    func playButtonTapped(_ firstPlayer: Player, _ secondPlayer: Player) {
        let triviaGameViewController = view.storyboard!.instantiateViewController(withIdentifier: ViewControllersIdentifiers.triviaGame) as! TriviaGameViewController
        triviaGameViewController.firstPlayer = firstPlayer
        triviaGameViewController.secondPlayer = secondPlayer
        view.navigationController!.pushViewController(triviaGameViewController, animated: true)
    }
}

