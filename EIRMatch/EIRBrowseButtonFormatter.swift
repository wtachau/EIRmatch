//
//  EIRBrowseButtonFormatter.swift
//  EIRMatch
//
//  Created by William Tachau on 7/24/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

extension EIRBrowseController {
    
    // Sets up "identity" buttons
    func setUpButton(index:Int) {
        let buttonSize = Float(50)
        var yOffset = Float(index/3 * 110 + 80)
        
            ButtonArray[index].frame = CGRectMake((Float(index%3+1)*0.25 * self.view.bounds.width) - buttonSize/2.0, yOffset, buttonSize, buttonSize)
            ButtonArray[index].layer.cornerRadius = 10
            ButtonArray[index].layer.masksToBounds = true
            let padding = Float(10.0)
            ButtonArray[index].imageEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
            ButtonArray[index].backgroundColor = buttonColor
            ButtonArray[index].addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            switch index%3 {
            case 0:
                ButtonArray[index].setImage(UIImage(named: "career.png"), forState: UIControlState.Normal)
                ButtonArray[index].setImage(UIImage(named: "career.png"), forState: UIControlState.Highlighted)
            case 1:
                ButtonArray[index].setImage(UIImage(named: "binary7.png"), forState: UIControlState.Normal)
                ButtonArray[index].setImage(UIImage(named: "binary7.png"), forState: UIControlState.Highlighted)
            case 2:
                ButtonArray[index].setImage(UIImage(named: "website8.png"), forState: UIControlState.Normal)
                ButtonArray[index].setImage(UIImage(named: "website8.png"), forState: UIControlState.Highlighted)
            default:
                break
            }
    }
    
    // Sets up "submit" button
    func setUpSubmitButton() -> UIButton {
        
        let width = Float(80)
        var b = UIButton(frame: CGRectMake((view.bounds.width - width) / 2.0,
            280, width, 40))
        b.layer.cornerRadius = 10
        b.layer.masksToBounds = true
        b.setTitle("submit >", forState: UIControlState.Normal)
        b.titleLabel.textColor = UIColor.whiteColor()
        b.layer.borderWidth = 2
        b.layer.borderColor = UIColor.whiteColor().CGColor
        b.addTarget(self, action: "submitButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(b)
        return b
    }
    
}
