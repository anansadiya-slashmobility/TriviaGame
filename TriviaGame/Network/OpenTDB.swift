//
//  OpenTDB.swift
//  TriviaGame
//
//  Created by Anan Sadiya on 15/12/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import Foundation
import Moya

enum OpenTDB {
    case getQuestions
}

extension OpenTDB: TargetType {
    var baseURL: URL {
        return URL(string: "https://opentdb.com/api.php?amount=" + String(API.questionsNumber) + "&type=multiple")!
    }
    
    var path: String {
        switch self {
        case .getQuestions: return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getQuestions: return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getQuestions:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

