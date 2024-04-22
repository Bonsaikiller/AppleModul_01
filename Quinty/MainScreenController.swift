//
//  MainScreenController.swift
//  Quinty
//
//  Created by Susanne Dvorak on 16.04.24.
//

import UIKit

class MainScreenController: UIViewController {
    
    //Selector
    enum Mode {
        case flashCard, quiz
    }
    enum State {
        case answer, question, score
    }
    // Outlets
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var qCounter: UILabel!
    @IBOutlet weak var qImage: UIImageView!
    @IBOutlet weak var qLabel: UILabel!
    @IBOutlet weak var answerButton_01: UIButton!
    @IBOutlet weak var answerButton_02: UIButton!
    @IBOutlet weak var answerButton_03: UIButton!
    @IBOutlet weak var backButtonQuiz: UIButton!
    @IBOutlet weak var quizNextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var flashAnswerButton: UIButton!
    @IBOutlet weak var flashNextButton: UIButton!
    
    // Variables
    var mode: Mode = .flashCard {
        didSet {
            switch mode {
            case.flashCard: setupFlashcards()
            case.quiz: setupQuiz()
            }
            updateView()
        }
    }
    
    var state: State = .question
    var counter = 0
    var currentQuestionIndex = 0
    var randomQuestion = [String]()
    var correctAnswer = false
    var score = 0
    
    
    // Update MainView function
    
    func updateView() {
        let theImage = myArray[currentQuestionIndex].id
        let myImage = UIImage(named: theImage)
        qImage.image = myImage
        
        let question = myArray[currentQuestionIndex].question
        qCounter.text = "\(counter) \\ 20"
        switch mode {
            case.flashCard: updateFlashCard(question: question)
            case.quiz: updateQuiz(question: question)
            }
    }
    
    
    // shuffles the answers for Quiz Mode
    func randomizeAnsers() {
        if (mode == .quiz) {
            let random = [myArray[currentQuestionIndex].answer1, myArray[currentQuestionIndex].answer2, myArray[currentQuestionIndex].answer3]
            randomQuestion = random.shuffled()
            answerButton_01.setTitle(randomQuestion[0], for: .normal)
            answerButton_02.setTitle(randomQuestion[1], for: .normal)
            answerButton_03.setTitle(randomQuestion[2], for: .normal)
        }
        
    }
    // checks if randomQuestionIndex = answer1 (which is always the correct answer)
    func checkAnswer(number: Int) {
        correctAnswer = false
        if randomQuestion[number] == myArray[currentQuestionIndex].answer1 {
            correctAnswer = true
        }
    }
    
    // setup for Buttons
    func buttonsAll() {
        if (mode == .flashCard) {
            backButton.isHidden = false
            backButtonQuiz.isHidden = true
            quizNextButton.isHidden = true
            flashAnswerButton.isHidden = false
            answerButton_01.isHidden = true
            answerButton_02.isHidden = true
            answerButton_03.isHidden = true
        } else {
            backButton.isHidden = true
            quizNextButton.isHidden = false
            backButtonQuiz.isHidden = false
            answerButton_01.isHidden = false
            answerButton_02.isHidden = false
            answerButton_03.isHidden = false
            flashAnswerButton.isHidden = true
            flashNextButton.isHidden = true
        }
    }
    

    // ------------  Buttons ACTIONS function  ----------------
    
    // flashCard Answer
    @IBAction func flashAnwserButton(_ sender: Any) {
        state = .answer
        if flashAnswerButton.titleLabel?.text == "Weiter lernen" {
            setupFlashcards()
        }
        updateView()
    }
    
    // flashCard Next
    @IBAction func flashNextButton(_ sender: Any) {
        state = .question
        if currentQuestionIndex >= myArray.count - 1 {
            state = .score
            flashNextButton.isHidden = true
        } else {
            currentQuestionIndex += 1
        }
        counter += 1
        updateView()
    }
    
    
    // Quiz Answerbuttons
    @IBAction func answerButton_01(_ sender: Any) {
        checkAnswer(number: 0)
            if correctAnswer == true {
                answerButton_01.setTitle("Richtige Antwort!", for: .normal)
                score += 1
            } else {
                answerButton_01.setTitle("Leider falsch.", for: .normal)
            }
        answerButton_02.isEnabled = false
        answerButton_03.isEnabled = false
        
        // resets everything
        if state == .score {
            state = .question
            setupQuiz()
            updateView()
        }
    }
    
    @IBAction func answerButton_02(_ sender: Any) {
        checkAnswer(number: 1)
            if correctAnswer == true {
                answerButton_02.setTitle("Richtige Antwort!", for: .normal)
                score += 1
            } else {
                answerButton_02.setTitle("Leider falsch.", for: .normal)
            }
        answerButton_01.isEnabled = false
        answerButton_03.isEnabled = false
    }
    
    @IBAction func answerButton_03(_ sender: Any) {
        checkAnswer(number: 2)
            if correctAnswer == true {
                answerButton_03.setTitle("Richtige Antwort!", for: .normal)
                score += 1
            } else {
                answerButton_03.setTitle("Leider falsch.", for: .normal)
            }
        answerButton_01.isEnabled = false
        answerButton_02.isEnabled = false
    }
    
    @IBAction func quizNextButton(_ sender: Any) {
        state = .question
        counter += 1
        if currentQuestionIndex >= myArray.count - 1  {
            state = .score
        } else {
            currentQuestionIndex += 1
            
            randomizeAnsers()
        }
        updateView()
        resetButtons()
    }
    
    
    func resetButtons() {
        answerButton_01.isEnabled = true
        answerButton_02.isEnabled = true
        answerButton_03.isEnabled = true
        qLabel.textColor = UIColor(red: 40/255, green: 87/255, blue: 88/255, alpha: 1.0)
        if state == .score {
            quizNextButton.isHidden = true
            answerButton_01.setTitle("Nochmal spielen", for: .normal)
            answerButton_02.isHidden = true
            answerButton_03.isHidden = true

            qLabel.text = "Du hast \(score) von 20 Punkten erreicht" //"
            qLabel.textColor = UIColor(red: 15/255, green: 140/255, blue: 140/255, alpha: 1.0)
        
        }
}
    

// ---- sets the views ----
       
    // function set Flashcard View (resets everything)
    func setupFlashcards(){
        state = .question
        flashAnswerButton.setTitle("Antwort zeigen", for: .normal)
        flashNextButton.isHidden = false
        currentQuestionIndex = 0
        counter = 0
        buttonsAll()
    }
    
    // func set Quiz View (resets everything)
    func setupQuiz() {
        state = .question
        currentQuestionIndex = 0
        counter = 0
        score = 0
        buttonsAll()
        randomizeAnsers()
        
        if state != .score {
            resetButtons()
        }
    }
 
    // Switch Mode function
      
     @IBAction func switchModes(_ sender: Any) {
            if modeSelector.selectedSegmentIndex == 0 {
                mode = .flashCard
                setupFlashcards()
            } else {
                mode = .quiz
                setupQuiz()
                randomizeAnsers()
            }
        }
    
// ------------------ Updates the Views --------------------
    
    // Update flashCard View
    
    func updateFlashCard(question: String) {
        if state == .question {
            qLabel.text = question // myArray[currentQuestionIndex].question
            } else if state == .answer {
                qLabel.text = myArray[currentQuestionIndex].flashAnswer
            }
        if  state == .score {
            qLabel.text = "Du hast alle Fragen durchgearbeitet. \n Klicke auf den Button und lerne weiter oder gehe auf Beenden."
            flashAnswerButton.setTitle("Weiter lernen", for: .normal)
            }
        buttonsAll() // to reset the Buttons
    }
    
    // Update quiz View
    
    func updateQuiz(question: String) {
        if state == .question {
            qLabel.text = question // myArray[currentQuestionIndex].question
        } else if state == .answer {
            print("answer")
        }
    }
    
    // updates the Questions
    
    func updateQA() {
  
         }
 

// ---------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
}
