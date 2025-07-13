//
//  QuestionModel.swift
//  ScrambledWords
//
//  Created by Joy Swaroop on 13/07/25.
//

import Foundation

struct Question{
    let image : String
    var scrambledLetters:[Letter]
    
    let answer: String
}


//MARK: - Generates Questions
extension Question{
    static func generateQuestion() -> [Question] {
        return [
            Question(image: "orange", scrambledLetters: [
                Letter(id: 0, text: "A"),
                Letter(id: 1, text: "G"),
                Letter(id: 2, text: "R"),
                Letter(id: 3, text: "N"),
                Letter(id: 4, text: "O"),
                Letter(id: 5, text: "E")
            ], answer: "ORANGE"),
            Question(image: "banana", scrambledLetters: [
                Letter(id: 0, text: "A"),
                Letter(id: 1, text: "N"),
                Letter(id: 2, text: "A"),
                Letter(id: 3, text: "N"),
                Letter(id: 4, text: "B"),
                Letter(id: 5, text: "A")
            ], answer: "BANANA"),
            Question(image: "apple", scrambledLetters: [
                Letter(id: 0, text: "P"),
                Letter(id: 1, text: "A"),
                Letter(id: 2, text: "P"),
                Letter(id: 3, text: "L"),
                Letter(id: 4, text: "E")
            ], answer: "APPLE")
        ]
    }
}
