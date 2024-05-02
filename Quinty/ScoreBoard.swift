//
//  ScoreBoard.swift
//  Quinty
//
//  Created by Susanne Dvorak on 24.04.24.
//

import UIKit

class ScoreBoard: UIViewController {

    @IBOutlet weak var ScoreImage: UIImageView!
    
    @IBOutlet weak var scoreText: UILabel!
    
    @IBAction func backToMain(_ sender: Any) {
       // mode = .quiz
    }
    
    var scoreImage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        scoreText.text = scoreImage
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
