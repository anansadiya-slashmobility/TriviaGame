//
//  Question.swift
//  TriviaGame
//
//  Created by Anan Sadiya on 15/12/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import Foundation

class Question: Codable {
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}

extension Question {
    enum CodingKeys: String, CodingKey {
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
