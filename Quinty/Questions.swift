//
//  Questions.swift
//  Quinty
//
//  Created by Susanne Dvorak on 16.04.24.
//

import Foundation
import UIKit

// Definition struct Question

struct Question {
    let id: String
    let question: String
    let flashAnswer: String
    let answer1: String
    let answer2: String
    let answer3: String
}

struct Answers {
  
}

let myArray: [Question] = [
    Question(id: "01", question: "1 Welche Note ist das?" ,flashAnswer: "Das ist eine viertel Note.", answer1: "Viertel Note", answer2: "Ganze Note" ,  answer3: "Sechzentel Note"),
    Question(id: "02", question: "2 Welche Note ist das?", flashAnswer: "Die Note hat zwei Fähnchen. Daher ist sie eine sechzentel Note", answer1: "richtige ", answer2: "Halbe Note", answer3: "Sechzentel Note"),
    Question(id: "03", question: "3 Welche Note ist das?", flashAnswer: "Das ist eine \"enharmonische Verwechslung \". Die Note stellt sowohl ein Ges als auch ein Fis das.", answer1: "Richtige Dis/Es", answer2: "Ges/Fis", answer3: "Cis/Des")

]


