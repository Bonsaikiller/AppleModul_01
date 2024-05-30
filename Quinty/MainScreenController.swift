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
    // Outlets:
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var qCounter: UILabel! // QuestionCounter
    @IBOutlet weak var qImage: UIImageView! //QuestionImmage
    @IBOutlet weak var qLabel: UILabel! //QuestionText
    @IBOutlet weak var button_01: UIButton!
    @IBOutlet weak var button_02: UIButton!
    @IBOutlet weak var button_03: UIButton!
    @IBOutlet weak var backButtonQuiz: UIButton!
    @IBOutlet weak var nextButtonQuiz: UIButton! // Backbutton on left side in Quizmode
    @IBOutlet weak var backButton: UIButton! //Backbutton in the middle in Flashcardmode and final screen in Quizmode


    
    
// ----------------- Variables ------------------
 
    // Sets first flashCard to Starting Mode  - Switching Modes
    var mode: Mode = .flashCard {
        didSet {
            switch mode {
            case.flashCard: setupFlashcards()
              modeSelector.selectedSegmentIndex = 0 // probably redundant?
            case.quiz: setupQuiz()
            }
           updateView()
        }
    }
   
    var state: State = .question // sets state
    var counter = 1
    var currentQuestionIndex = 0
    
    var shuffledList: [Question] = [] //empty Array for shuffled questions in Quizmode
    
    var randomAnswer = [String]() //empty Array for func "randomizeAnswers"
    var correctAnswer = false // used in func "checkAnswer"
    var score = 0
    
// ------------ Update View function --------------//
    func updateView() {
        var question = questionList[currentQuestionIndex].question
        var theImage = questionList[currentQuestionIndex].id
        qCounter.isHidden = false // necessary because Counter is Hidden in final screen
        if mode == .quiz {
            theImage = shuffledList[currentQuestionIndex].id
            question = shuffledList[currentQuestionIndex].question
        }
        let image = UIImage(named: theImage)
        qImage.image = image
        qCounter.text = "\(counter) \\ 10"

        switch mode {
            case.flashCard: updateFlashCard(question: question)
            case.quiz: updateQuiz(questionShuffled: question)
            }
    }
    
    // shuffles answers for Quiz Mode
    func randomizeAnswers() {
        if (mode == .quiz) {
            let random = [shuffledList[currentQuestionIndex].answer1, shuffledList[currentQuestionIndex].answer2, 
                          shuffledList[currentQuestionIndex].answer3]
            randomAnswer = random.shuffled()
            button_01.setTitle(randomAnswer[0], for: .normal)
            button_02.setTitle(randomAnswer[1], for: .normal)
            button_03.setTitle(randomAnswer[2], for: .normal)
        }
    }
    
    // checks if randomQuestionIndex == answer1 (which is always the correct one)
    func checkAnswer(number: Int) {
        correctAnswer = false
        if randomAnswer[number] == shuffledList[currentQuestionIndex].answer1 {
            correctAnswer = true
        }
    }
    
    // Buttonsetup
    func buttonsAll() {
        if (mode == .flashCard) {
            backButton.isHidden = false
            backButtonQuiz.isHidden = true
            nextButtonQuiz.isHidden = true
            button_03.isHidden = true
          
        } else {
            backButton.isHidden = true
            nextButtonQuiz.isHidden = false
            backButtonQuiz.isHidden = false
            button_01.isHidden = false
            button_02.isHidden = false
            button_03.isHidden = false
        
        }
    }
    
// ------------ Button STYLES ----------
    //Basic Style
    func buttonStyle(buttonName: UIButton) {
        buttonName.tintColor = UIColor(red: 15/255, green: 140/255, blue: 140/255, alpha: 1.0)
        buttonName.layer.borderColor = CGColor(red: 15/255, green: 140/255, blue: 140/255, alpha: 1.0)
        buttonName.layer.borderWidth = 1.5
        buttonName.layer.shadowColor = CGColor(red: 40/255, green: 87/255, blue: 88/255, alpha: 1.0)
        buttonName.layer.shadowRadius = 0
        buttonName.layer.shadowOffset = CGSize(width: 0, height: 5)
        buttonName.layer.shadowOpacity = 1
        buttonName.layer.cornerRadius = 5
    }

    // enabled = false, Style = grey
    func greyButton(buttonName: UIButton){
        buttonName.layer.shadowColor = CGColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1.0)
        buttonName.layer.borderColor = CGColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1.0)
        buttonName.isEnabled = false
    }
    
    // wrong answer
    func failed(buttonName: UIButton){
        buttonName.setTitle("Leider falsch.", for: .normal)
        buttonName.tintColor = UIColor(red: 190/255, green: 0/255, blue: 0/255, alpha: 1.0)
        buttonName.layer.shadowColor = CGColor(red: 190/255, green: 0/255, blue: 0/255, alpha: 1.0)
        buttonName.layer.borderColor = CGColor(red: 190/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }
    
    // correct answer
    func passed(buttonName: UIButton){
        buttonName.setTitle("Richtige Antwort!", for: .normal)
        buttonName.tintColor = UIColor(red: 0/255, green: 160/255, blue: 75/255, alpha: 1.0)
        buttonName.layer.shadowColor = CGColor(red: 0/255, green: 160/255, blue: 75/255, alpha: 1.0)
        buttonName.layer.borderColor = CGColor(red: 0/255, green: 160/255, blue: 75/255, alpha: 1.0)
    }
    
    // ------------  Buttons ACTION functions  ----------------
    

    @IBAction func button_01(_ sender: Any) {
        switch mode {
            //FLASHCARD MODE - AnswerButton
            case.flashCard:
                if state == .score {
                setupFlashcards()//resets everything
                updateView()
                } else {
                    state = .answer
                    updateView()
                    greyButton(buttonName: button_01)
                }
               
            // QUIZ MODE - AnswerButton
            case.quiz:
                checkAnswer(number: 0)
                if correctAnswer == true {
                        passed(buttonName: button_01)
                        score += 1
                } else {
                    failed(buttonName: button_01)
                }
                    greyButton(buttonName: button_02)
                    greyButton(buttonName: button_03)
           
                if state != .score {
                    state = .answer
                    showQuizAnswer()
                } else  if state == .score {  // resets everything
                    setupQuiz()
                    updateView()
                }
            }
        }
    @IBAction func button_02(_ sender: Any) {
        switch mode {
            //FLASHCARD MODE - NEXTButton
            case.flashCard:
                state = .question
                resetButtons()
                if currentQuestionIndex >= questionList.count - 1 {
                    state = .score
                    button_02.isHidden = true
                } else {
                    currentQuestionIndex += 1
                }
                if counter < 10 {
                    counter += 1
                }
               updateView()
            
            //QUIZ MODE - AnswerButton
            case.quiz:
                state = .answer
                checkAnswer(number: 1)
                if correctAnswer == true {
                    passed(buttonName: button_02)
                    score += 1
                } else {
                    failed(buttonName: button_02)
                }
                showQuizAnswer()
                greyButton(buttonName: button_01)
                greyButton(buttonName: button_03)
            }
        }
    // QUIZMODE - AnswerButton
    @IBAction func button_03(_ sender: Any) {
        state = .answer
        checkAnswer(number: 2)
            if correctAnswer == true {
                passed(buttonName: button_03)
                score += 1
            } else {
                failed(buttonName: button_03)
            }
        showQuizAnswer()
        greyButton(buttonName: button_01)
        greyButton(buttonName: button_02)
    }
    
    // QUIZMODE - NextButton
    @IBAction func nextButtonQuiz(_ sender: Any) {
        state = .question
        if currentQuestionIndex >= shuffledList.count - 1  {
            state = .score
        } else {
            currentQuestionIndex += 1
            randomizeAnswers()
        }
        if counter < 10 {
            counter += 1
        }
        nextButtonQuiz.isEnabled = false
        updateView()
        resetButtons()
    }
    
    func showQuizAnswer() {
        if mode == .quiz {
            qLabel.text = shuffledList[currentQuestionIndex].detailedAnswer
        }
        nextButtonQuiz.isEnabled = true
        if counter == 10 {
            nextButtonQuiz.setTitle("Ergebnis", for: .normal)
        }
    }
    
    
    // Resets all Buttons to enabled = true
    func resetButtons() {
          button_01.isEnabled = true
          button_02.isEnabled = true
          button_03.isEnabled = true
        
        // standard Color
        qLabel.textColor = UIColor(red: 40/255, green: 87/255, blue: 88/255, alpha: 1.0)
        
        // Buttonsettings for score
        if state == .score {
            nextButtonQuiz.isHidden = true
            button_01.setTitle("Nochmal spielen", for: .normal)
            button_02.isHidden = true
            button_03.isHidden = true
            //Score Color
            qLabel.text = "Du hast \(score) von 10 Punkten erreicht! \n Spiele nochmal oder klicke unten auf Beenden." //"
            qLabel.textColor = UIColor(red: 15/255, green: 140/255, blue: 140/255, alpha: 1.0)
        }
}
    
// ------------------ sets the Views --------------------
       
    // set Flashcard View (resets everything if mode is switched to Üben)
    func setupFlashcards(){
        state = .question
        button_01.setTitle("Antwort zeigen", for: .normal)
        currentQuestionIndex = 0
        counter = 1
    }
    
    // set Quiz View (resets everything if mode is switched to Quiz)
    func setupQuiz() {
        shuffledList = questionList.shuffled()
        state = .question
        nextButtonQuiz.setTitle("Weiter", for: .normal)
        nextButtonQuiz.isEnabled = false
        currentQuestionIndex = 0
        counter = 1
        score = 0
        buttonsAll()
        randomizeAnswers()
        if state != .score {
            resetButtons()
        }
    }

    // Switch Mode function
     @IBAction func switchModes(_ sender: Any) {
            if modeSelector.selectedSegmentIndex == 0 {
                mode = .flashCard
                resetButtons() //else button_02 and 03 aren't enabled if user switches to Üben before pressing "Weiter"
            } else {
                mode = .quiz
            }
        }
    
// ------------------ Updates the Views --------------------
    
    // Update flashCard View
    func updateFlashCard(question: String) {
        if state == .question {
            button_02.isHidden = true
            button_01.setTitle("Antwort zeigen", for: .normal)
             qLabel.text = question
            } else if state == .answer {
                qLabel.text = questionList[currentQuestionIndex].detailedAnswer
                button_02.isHidden = false
                button_02.setTitle("Nächste Frage", for: .normal)
            }
        if  state == .score {
            qLabel.textColor = UIColor(red: 15/255, green: 140/255, blue: 140/255, alpha: 1.0)
            qLabel.text = "Du hast alle Fragen durchgearbeitet. \n Klicke auf den Button und lerne weiter oder gehe auf Beenden."
            button_01.setTitle("Weiter lernen", for: .normal)
            button_02.isHidden = true
            let finalImage = "quinty_fin" //String(score)
            qImage.image = UIImage(named: finalImage)
            qCounter.isHidden = true

            }
        buttonsAll() // to set the Buttons at the Start
        buttonStyle(buttonName: button_01)
        buttonStyle(buttonName: button_02)
    }
    
    // Update quiz View
    func updateQuiz(questionShuffled: String) {
        if state == .question {
            qLabel.text = questionShuffled
        }
        // converts score to String
       if state == .score {
           let scoreImage = String(score)
           qImage.image = UIImage(named: scoreImage) //score = UIImage
           backButton.isHidden = false // displays backButton in the middle
           backButtonQuiz.isHidden = true // hides backButton on the left
           qCounter.isHidden = true
        }
        buttonStyle(buttonName: button_01)
        buttonStyle(buttonName: button_02)
        buttonStyle(buttonName: button_03)
    }
    

// ---------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
}
