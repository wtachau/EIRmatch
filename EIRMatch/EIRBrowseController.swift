//
//  EIRMenuController.swift
//  EIRMatch
//
//  Created by William Tachau on 7/21/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import Foundation
import UIKit

class EIRBrowseController : UIViewController {

    // keep track of "ID" buttons
    var ButtonArray = Array<UIButton>()
    
    var IdentifyText : UILabel?
    var ChooseText : UILabel?
    
    var SubmitButton : UIButton?
    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  configure view
        view.backgroundColor = backgroundColor
        
        
        // Set up identify text line
        IdentifyText = UILabel(frame: CGRectMake(0, 40, view.bounds.width, 40))
        
        if let idText = IdentifyText {
            idText.textAlignment = NSTextAlignment.Center
            idText.text = "I am a"
            idText.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
            idText.textColor = UIColor.whiteColor()
        }
        view.addSubview(IdentifyText)
        
        // Set up choose text line
        ChooseText = UILabel(frame: CGRectMake(0, 150, view.bounds.width, 40))
        
        if let chooseText = ChooseText {
            chooseText.textAlignment = NSTextAlignment.Center
            chooseText.text = "looking for a"
            chooseText.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
            chooseText.textColor = UIColor.whiteColor()
        }
        view.addSubview(ChooseText)
        
        // array of buttons
        for i in 0..<6 {
            ButtonArray.append(UIButton())
            setUpButton(i)
            view.addSubview(ButtonArray[i])
        }
        
        // next button
        SubmitButton = setUpSubmitButton()
    }
}

extension EIRBrowseController {
    
    // If an ID button is tapped
    func buttonTapped(button : UIButton) {
        if button.layer.borderWidth == 0 {
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.whiteColor().CGColor
            button.selected = true
        } else {
            button.layer.borderWidth = 0
            button.selected = false
        }
    }
    
    // If the Submit button is tapped
    func submitButtonTapped(button : UIButton) {
        navigationController.popViewControllerAnimated(true)
        for button in ButtonArray {
            //println(button.selected)
        }
    }
}






























