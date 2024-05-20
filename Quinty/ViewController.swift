//
//  ViewController.swift
//  Quinty
//
//  Created by Susanne Dvorak on 11.04.24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startBut: UIButton!
 
    
    // Button function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startBut.tintColor = UIColor(red: 15/255, green: 140/255, blue: 140/255, alpha: 1.0)
        //startBut.layer.borderColor = CGColor(red: 15/255, green: 140/255, blue: 140/255, alpha: 1.0)
        //startBut.layer.borderWidth = 1
        startBut.layer.shadowColor = CGColor(red: 40/255, green: 87/255, blue: 88/255, alpha: 1.0)
        startBut.layer.shadowRadius = 0
        startBut.layer.shadowOffset = CGSize(width: 0, height: 5)
        startBut.layer.shadowOpacity = 1
        startBut.layer.cornerRadius = 5

    
      
           // Do any additional setup after loading the view.
    }
   
}
