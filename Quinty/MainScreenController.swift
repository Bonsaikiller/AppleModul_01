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
    
// ----------------- Variables ------------------
    
    // Starting mode
    var mode: Mode = .flashCard {
        didSet {
            switch mode {
            case.flashCard: setupFlashcards()
                modeSelector.selectedSegmentIndex = 0
            case.quiz: setupQuiz()
            }
           updateView()
        }
    }
    
    var state: State = .question // sets state
    
    var counter = 1
    var currentQuestionIndex = 0
    
    let fixedList: [Question] = questionList
    var shuffledList: [Question] = [] //questionList.shuffled()  //shuffled questions for Quizmode
    
    var randomQuestion = [String]() //empty Array for func "randomizeAnswers"
    var correctAnswer = false // used in func "checkAnswer"
    var score = 0
    
    
    // Update View function
    func updateView() {
        var question = fixedList[currentQuestionIndex].question
        var theImage = fixedList[currentQuestionIndex].id
        
        let Image = UIImage(named: theImage)
        qImage.image = Image
        
        if mode == .quiz {
            theImage = shuffledList[currentQuestionIndex].id
            question = shuffledList[currentQuestionIndex].question
            // converts score to String
            var scoreImage = String(score)
            if state == .score {
                qImage.image = UIImage(named: scoreImage) //score = UIImage
            }
        }
        qCounter.text = "\(counter) \\ 10"

        switch mode {
            case.flashCard: updateFlashCard(question: question)
            case.quiz: updateQuiz(questionShuffled: question)
            }
    }
    
    // shuffles the answers for Quiz Mode
    func randomizeAnsers() {
        if (mode == .quiz) {
            let random = [shuffledList[currentQuestionIndex].answer1, shuffledList[currentQuestionIndex].answer2, shuffledList[currentQuestionIndex].answer3]
            randomQuestion = random.shuffled()
            answerButton_01.setTitle(randomQuestion[0], for: .normal)
            answerButton_02.setTitle(randomQuestion[1], for: .normal)
            answerButton_03.setTitle(randomQuestion[2], for: .normal)
        }
        
    }
    // checks if randomQuestionIndex = answer1 (which is always the correct answer)
    func checkAnswer(number: Int) {
        correctAnswer = false
        if randomQuestion[number] == shuffledList[currentQuestionIndex].answer1 {
            correctAnswer = true
        }
    }
    
    // Buttonsetup
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
    
// ------------ Button STYLES ----------
    //Basic Style
    func buttonStyle(buttonName: UIButton) {
        buttonName.tintColor = UIColor(red: 15/255, green: 140/255, blue: 140/255, alpha: 1.0)
        buttonName.layer.borderColor = CGColor(red: 15/255, green: 140/255, blue: 140/255, alpha: 1.0)
        buttonName.layer.borderWidth = 1
        buttonName.layer.shadowColor = CGColor(red: 40/255, green: 87/255, blue: 88/255, alpha: 1.0)
        buttonName.layer.shadowRadius = 0
        buttonName.layer.shadowOffset = CGSize(width: 0, height: 5)
        buttonName.layer.shadowOpacity = 1
        buttonName.layer.cornerRadius = 5
    }

    // enabled = false
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
    
    //FLASHCARD MODE
    // AnswerButton
    @IBAction func flashAnwserButton(_ sender: Any) {
        state = .answer
        if flashAnswerButton.titleLabel?.text == "Weiter lernen" {
            setupFlashcards()
        }
        resetButtons()
        updateView()
    }
    
    // NexButton
    @IBAction func flashNextButton(_ sender: Any) {
        state = .question
        if currentQuestionIndex >= fixedList.count - 1 {
            state = .score
            flashNextButton.isHidden = true
            } else {
                currentQuestionIndex += 1
            }
        if counter < 10 {
            counter += 1
        }
        updateView() //
        greyButton(buttonName: flashNextButton)
    }
    
    // QUIZ MODE
    // Answerbuttons
    @IBAction func answerButton_01(_ sender: Any) {
        if state != .score {
            state = .answer
            showQuizAnswer()
        }
        checkAnswer(number: 0)
            if correctAnswer == true {
                passed(buttonName: answerButton_01)
                score += 1
            } else {
                failed(buttonName: answerButton_01)
            }
        greyButton(buttonName: answerButton_02)
        greyButton(buttonName: answerButton_03)
        
        // resets everything
        if state == .score {
            state = .question
            setupQuiz()
            updateView()
        }
    }
    
    @IBAction func answerButton_02(_ sender: Any) {
        state = .answer
        checkAnswer(number: 1)
            if correctAnswer == true {
                passed(buttonName: answerButton_02)
                score += 1
            } else {
                failed(buttonName: answerButton_02)
            }
        showQuizAnswer()
        greyButton(buttonName: answerButton_01)
        greyButton(buttonName: answerButton_03)
        
    }
    
    @IBAction func answerButton_03(_ sender: Any) {
        state = .answer
        checkAnswer(number: 2)
            if correctAnswer == true {
                passed(buttonName: answerButton_03)
                score += 1
            } else {
                failed(buttonName: answerButton_03)
            }
        showQuizAnswer()
        greyButton(buttonName: answerButton_01)
        greyButton(buttonName: answerButton_02)
    }
    
    // NetButton
    @IBAction func quizNextButton(_ sender: Any) {
        state = .question
        if currentQuestionIndex >= shuffledList.count - 1  {
            state = .score
        } else {
            currentQuestionIndex += 1
            randomizeAnsers()
        }
        if counter < 10 {
            counter += 1
        }
        updateView()
        resetButtons()
    }
    
    func showQuizAnswer() {
        if mode == .quiz {
            qLabel.text = shuffledList[currentQuestionIndex].flashAnswer
        }
        if counter == 10 {
            quizNextButton.setTitle("Ergebnis", for: .normal)
            print("10")
        }
    }
    
    // Resets all Buttons to enabled = true
    func resetButtons() {
        answerButton_01.isEnabled = true
        answerButton_02.isEnabled = true
        answerButton_03.isEnabled = true
        flashAnswerButton.isEnabled = true
        flashNextButton.isEnabled = true
        
        // standard Color
        qLabel.textColor = UIColor(red: 40/255, green: 87/255, blue: 88/255, alpha: 1.0)
        
        // Buttonsettings for score
        if state == .score {
            quizNextButton.isHidden = true
            answerButton_01.setTitle("Nochmal spielen", for: .normal)
            answerButton_02.isHidden = true
            answerButton_03.isHidden = true
            //Score Color
            qLabel.text = "Du hast \(score) von 10 Punkten erreicht" //"
            qLabel.textColor = UIColor(red: 15/255, green: 140/255, blue: 140/255, alpha: 1.0)
        }
}
    
// ------------------ sets the Views --------------------
       
    // set Flashcard View (resets everything if mode is switched to Üben)
    func setupFlashcards(){
        state = .question
        flashAnswerButton.setTitle("Antwort zeigen", for: .normal)
        currentQuestionIndex = 0
        counter = 1
        //buttonsAll()
    }
    
    // set Quiz View (resets everything if mode is switched to Quiz)
    func setupQuiz() {
        shuffledList = questionList.shuffled()
        state = .question
        quizNextButton.setTitle("Weiter", for: .normal)
        currentQuestionIndex = 0
        counter = 1
        score = 0
        buttonsAll()
        randomizeAnsers()
      // print("Quiz Setup called")
        if state != .score {
            resetButtons()
        }
    }
 
    // Switch Mode function
     @IBAction func switchModes(_ sender: Any) {
            if modeSelector.selectedSegmentIndex == 0 {
                mode = .flashCard
            } else {
                mode = .quiz
                randomizeAnsers()
            }
        }
    
// ------------------ Updates the Views --------------------
    
    // Update flashCard View
    func updateFlashCard(question: String) {
        if state == .question {
             flashNextButton.isHidden = true
             qLabel.text = question
            } else if state == .answer {
                qLabel.text = fixedList[currentQuestionIndex].flashAnswer
                flashNextButton.isHidden = false
            }
        if  state == .score {
            qLabel.text = "Du hast alle Fragen durchgearbeitet. \n Klicke auf den Button und lerne weiter oder gehe auf Beenden."
            flashAnswerButton.setTitle("Weiter lernen", for: .normal)
            }
        buttonsAll() // to set the Buttons at the Start
        buttonStyle(buttonName: flashAnswerButton)
        buttonStyle(buttonName: flashNextButton)
    }
    
    // Update quiz View
    func updateQuiz(questionShuffled: String) {
        if state == .question {
            qLabel.text = questionShuffled
        }
        buttonStyle(buttonName: answerButton_01)
        buttonStyle(buttonName: answerButton_02)
        buttonStyle(buttonName: answerButton_03)
    }
    
// ---------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
       updateView()
    }
    
}
