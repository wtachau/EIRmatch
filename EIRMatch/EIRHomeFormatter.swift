//
//  EIRHomeFormatter.swift
//  EIRMatch
//
//  Created by William Tachau on 7/30/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

extension EIRHomeController {
    
    func formatShowAllButton() {
        // Initialize see all button
        let buttonWidth = CGFloat(80)
        let buttonHeight = CGFloat(40)
        ShowAllButton.frame = CGRectMake((view.bounds.width - buttonWidth)/2,
            0.70 * self.view.bounds.height,
            buttonWidth, buttonHeight)
        ShowAllButton.layer.cornerRadius = 10
        ShowAllButton.layer.masksToBounds = true
        ShowAllButton.addTarget(self, action: "showAllTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        ShowAllButton.setTitle("show all", forState: UIControlState.Normal)
        ShowAllButton.titleLabel.textColor = UIColor.whiteColor()
        ShowAllButton.layer.borderWidth = 2
        ShowAllButton.layer.borderColor = UIColor.whiteColor().CGColor
        view.addSubview(ShowAllButton)
    }
    
}
