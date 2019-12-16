//
//  ExtensionString.swift
//  TriviaGame
//
//  Created by Anan Sadiya on 17/12/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import Foundation

extension String {
    func convertSpecialCharacters(string: String) -> String {
        var newString = string
        let char_dictionary = [
            "&amp;" : "&",
            "&lt;" : "<",
            "&gt;" : ">",
            "&quot;" : "\"",
            "&apos;" : "'"
        ];
        for (escaped_char, unescaped_char) in char_dictionary {
            newString = newString.replacingOccurrences(of: escaped_char, with: unescaped_char, options: NSString.CompareOptions.literal, range: nil)
        }
        return newString
    }
}
