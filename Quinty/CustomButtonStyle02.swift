//
//  CustomButtonStyle02.swift
//  Quinty
//
//  Created by Susanne Dvorak on 16.04.24.
//  "Override - Code" from Aryaa SK Coding (YouTube) www.youtube.com/watch?v=D-EGR-lNw2Q

import UIKit

class CustomButtonStyle02: UIButton {

// overrides the inital method - to initialise the custom Buttom
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
// coder aDecoder - for initialising via Storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setShadow()
    }
    
// sets the Buttonshadow
  private func setShadow(){
     // self.layer.shadowColor = CGColor(red: 15/255, green: 140/255, blue: 140/255, alpha: 1.0)
        self.layer.shadowColor = CGColor(red: 40/255, green: 87/255, blue: 88/255, alpha: 1.0)
        self.layer.shadowRadius = 0
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 1
        self.layer.cornerRadius = 10
    }
}
