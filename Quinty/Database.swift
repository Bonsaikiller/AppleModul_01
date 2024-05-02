//
//  Questions.swift
//  Quinty
//
//  Created by Susanne Dvorak on 16.04.24.
//

import Foundation


// Definition of DataType "Question"

struct Question {
    let id: String
    let question: String
    let flashAnswer: String
    let answer1: String
    let answer2: String
    let answer3: String
}

let questionList: [Question] = [
         Question(id: "Q_01", question: "Welcher Schlüssel ist das?", flashAnswer: "Das ist der Violinschlüssel.", answer1: "Violinschlüssel", answer2: "Bassschlüssel", answer3: "Altschlüssel"),
         Question(id: "Q_02", question: "Welche Note ist das?", flashAnswer: "Die Note hat zwei Fähnchen. Daher ist sie eine sechzentel Note", answer1: "Sechzehntel Note ", answer2: "Halbe Note", answer3: "Achtel Note"),
         Question(id: "Q_03", question: "Welche Pause ist hier abgebildet?", flashAnswer: "Das ist eine Viertel Pause", answer1: "Viertel Pause", answer2: "Ganze Pause", answer3: "Sechzehntel Pause"),
         Question(id: "Q_04", question: "Was bedeutet dieses Zeichen?", flashAnswer: "Die Note wird um einen Halbtonschritt erhöht", answer1: "Die Note wird um einen Halbtonschritt erhöht ", answer2: "Die Note wird um einen Halbtonschritt verringert.", answer3: "Die Note wird um einen Halbtonschritt verlängert."),
         Question(id: "Q_05", question: "Was bedeutet diese Bezeichnung?", flashAnswer: "Das ist eine Tempobezeichnung und zeigt an wie schnell zu spielen ist. \"vivace\" steht für lebhaft.", answer1: "Lebhaft spielen.", answer2: "Sehr ruhig spielen.", answer3: "Sehr schnell spielen."),
         Question(id: "Q_06", question: "Welche Note ist das?" ,flashAnswer: "Das ist eine Viertel Note.", answer1: "Viertel Note", answer2: "Ganze Note", answer3: "Sechzentel Note"),
         Question(id: "Q_07", question: "Was bedeutet der Punkt an dieser Note?", flashAnswer: "Sie wird um die Hälfte ihres Wertes verlängert. Die hier abgebildete Halbe Note wird um eine Viertel Note verlängert = ¾.", answer1: "Verlängerung um die Hälfte des Wertes.", answer2: "Verkürzung um die Hälfte des Wertes.",  answer3: "Um eine Oktave höher spielen."),
         Question(id: "Q_08", question: "Wie wird der Violinschlüssel noch genannt?", flashAnswer: "Der Violinschlüssel wird auch G-Schlüssel genannt.\nEr ist höher als der Bass- und der Altschlüssel.", answer1: "G-Schlüssel", answer2: " F-Schlüssel", answer3: " C-Schlüssel"),
         Question(id: "Q_09", question: "Was bedeutet diese Bezeichnung?", flashAnswer: "Das ist eine Dynamikbezeichnung und zeigt an wie laut oder leise zu spielen ist. PPP steht für \"pianissimo possibile\" – so leise wie möglich.", answer1: "So leise wie möglich spielen.", answer2: "Laut spielen.", answer3: "Mittelleise spielen."),
         Question(id: "Q_10", question: "Wie wird der Bassschlüssel noch genannt?", flashAnswer: " Der Bassschlüssel wird auch F-Schlüssel genannt. Er ist tiefer als der Violin- und der Altschlüssel.", answer1: "F-Schlüssel", answer2: " G-Schlüssel", answer3: " C-Schlüssel"),
         //Question(id: "11", question: "Welche Note ist das?", flashAnswer: "Das ist eine \"enharmonische Verwechslung\". Die Note stellt sowohl ein Ges als auch ein Fis dar.", answer1: "Ges/Fis", answer2: "Dis/Es", answer3: "Cis/Des"),
]
