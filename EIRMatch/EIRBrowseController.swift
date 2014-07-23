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

    var IdentifyText : UILabel?
    var IdentifyManagement : UIButton?
    var IdentifyDeveloper : UIButton?
    var IdentifyDesign : UIButton?
    
    var ChooseText : UILabel?
    var ChooseManagement : UIButton?
    var ChooseDeveloper : UIButton?
    var ChooseDesign : UIButton?
    
    var NextButton : UIButton?
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
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
        
        // Set up identify buttons
        let buttonSize = Float(50)
        var yOffset = Float(IdentifyText!.frame.origin.y + 40)
        IdentifyManagement = UIButton(frame: CGRectMake((0.25 * self.view.bounds.width) - buttonSize/2, yOffset, buttonSize, buttonSize))
        IdentifyDeveloper = UIButton(frame:CGRectMake((self.view.bounds.width - buttonSize)/2, yOffset, buttonSize, buttonSize))
        IdentifyDesign = UIButton(frame:CGRectMake((0.75 * self.view.bounds.width) - buttonSize/2, yOffset, buttonSize, buttonSize))
        
        
        // Set up identify buttons
        yOffset = Float(ChooseText!.frame.origin.y + 40)
        ChooseManagement = UIButton(frame: CGRectMake((0.25 * self.view.bounds.width) - buttonSize/2, yOffset, buttonSize, buttonSize))
        ChooseDeveloper = UIButton(frame:CGRectMake((self.view.bounds.width - buttonSize)/2, yOffset , buttonSize, buttonSize))
        ChooseDesign = UIButton(frame:CGRectMake((0.75 * self.view.bounds.width) - buttonSize/2, yOffset, buttonSize, buttonSize))
        
        // array of buttons
        var ButtonArray = [IdentifyManagement, IdentifyDeveloper, IdentifyDesign,
            ChooseManagement, ChooseDeveloper, ChooseDesign]
        
        // customize button
        for (index, button) in enumerate(ButtonArray) {
            if let b = button {
                b.layer.cornerRadius = 10
                b.layer.masksToBounds = true
                let padding = Float(10.0)
                b.imageEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
                b.backgroundColor = buttonColor
                b.addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
                switch index%3 {
                    case 0:
                        b.setImage(UIImage(named: "career.png"), forState: UIControlState.Normal)
                        b.setImage(UIImage(named: "career.png"), forState: UIControlState.Highlighted)
                    case 1:
                        b.setImage(UIImage(named: "binary7.png"), forState: UIControlState.Normal)
                        b.setImage(UIImage(named: "binary7.png"), forState: UIControlState.Highlighted)
                    case 2:
                        b.setImage(UIImage(named: "website8.png"), forState: UIControlState.Normal)
                        b.setImage(UIImage(named: "website8.png"), forState: UIControlState.Highlighted)
                    default:
                        break
                }
            }
        }
        
        // next button
        let nextWidth = Float(80)
        NextButton = UIButton(frame: CGRectMake((view.bounds.width - nextWidth) / 2.0,
                                                280, nextWidth, 40))
        if let nextButton = NextButton {
            nextButton.layer.cornerRadius = 10
            nextButton.layer.masksToBounds = true
            nextButton.setTitle("find >", forState: UIControlState.Normal)
            nextButton.titleLabel.textColor = UIColor.whiteColor()
            nextButton.layer.borderWidth = 2
            nextButton.layer.borderColor = UIColor.whiteColor().CGColor
            nextButton.addTarget(self, action: "nextButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        // Add all buttons
        view.addSubview(IdentifyManagement)
        view.addSubview(IdentifyDeveloper)
        view.addSubview(IdentifyDesign)
        view.addSubview(ChooseManagement)
        view.addSubview(ChooseDeveloper)
        view.addSubview(ChooseDesign)
        view.addSubview(NextButton)
    }
}

extension EIRBrowseController {
    
    func buttonTapped(button : UIButton) {
        if button.layer.borderWidth == 0 {
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.whiteColor().CGColor
        } else {
            button.layer.borderWidth = 0
        }
    }
    
    func nextButtonTapped(button : UIButton) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        navigationController.pushViewController(appDelegate.resultsController, animated: true)
    }
    
}






























