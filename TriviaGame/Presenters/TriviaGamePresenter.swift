//
//  TriviaGamePresenter.swift
//  TriviaGame
//
//  Created by Anan Sadiya on 15/12/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import Foundation
import UIKit
import Moya

class TriviaGamePresenter {
    let provider = MoyaProvider<OpenTDB>()
    var view: TriviaGameViewController!
    
    func attachView(view: TriviaGameViewController) {
        self.view = view
    }
    
    func fetchData() {
        configureUI()
        provider.request(.getQuestions) { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success(let response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    let decoder = JSONDecoder()
                    let questions = try response.map([Question].self, atKeyPath: API.mapAtKeyPath, using: decoder)
                    DispatchQueue.main.async{
                        self!.seccessResponse(questions: questions)
                    }    
                }
                catch {
                    self!.emptyDataResponseError()
                }
                case .failure:
                    self!.networkResponseError()
            }
        }
    }
    
    private func configureUI() {
        view.hideQuestionLabel(hide: true)
        view.hideAnswersButtons(hide: true)
        view.showLoading()
    }
    
    private func seccessResponse(questions: [Question]) {
        self.view.questions = questions
        self.view.setTrivia()
    }
    
    private func emptyDataResponseError() {
        self.view.hideLoading()
        self.view.showAlert(alertTitle: EmptyData.title, alertMessage: EmptyData.message, alertActionTitle: EmptyData.action, alertType: .emptyError)
    }
    
    private func networkResponseError() {
        self.view.hideLoading()
        self.view.showAlert(alertTitle: NetworkError.title, alertMessage: NetworkError.message, alertActionTitle: NetworkError.action, alertType: .networkError)
    }
}
