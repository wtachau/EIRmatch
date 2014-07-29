//
//  EIRLoginCellFormatter.swift
//  EIRMatch
//
//  Created by William Tachau on 7/28/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

extension EIRLoginController {
    
    // format the cells
    func setUpCell(row: Int) -> UITableViewCell! {
        var Cell : UITableViewCell?
        Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        
        // Customize cell
        if let cell = Cell  {
            
            cell.backgroundColor = buttonColor
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if row < 0 {
                cell.backgroundColor = backgroundColor
            } else {
            
                switch row {
                case 0:
                    var loginText = UILabel(frame: cell.frame)
                    loginText.textColor = UIColor.whiteColor()
                    loginText.font = UIFont(name: "HelveticaNeue-Light", size: 20)
                    if onSignup {
                        loginText.text = "sign up below (tap to login)"
                    } else {
                        loginText.text = "login below (tap to signup)"
                    }
                    loginText.textAlignment = NSTextAlignment.Center
                    cell.backgroundColor = backgroundColor
                    cell.contentView.addSubview(loginText)
                case 1 :
                    setUpNameCell(cell)
                    cell.contentView.addSubview(nameField)
                case 2:
                    setUpPasswordCell(cell)
                    cell.contentView.addSubview(passwordField)
                case 3:
                    // If signing up, put email here. Otherwise, "done" button
                    if onSignup {
                        setUpEmailCell(cell)
                        cell.contentView.addSubview(emailField)
                    } else {
                        setUpDoneCell(cell)
                        cell.contentView.addSubview(loginIndicator)
                        cell.backgroundColor = backgroundColor
                        cell.contentView.addSubview(doneText)
                    }
                case 4:
                    if onSignup {
                        setUpCityPickerCell(cell)
                        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                        cell.contentView.addSubview(cityField)
                    } else {
                        cell.backgroundColor = backgroundColor
                    }
                default:
                    cell.backgroundColor = backgroundColor
                    // Done only goes here on signup (otherwise, two cells up)
                    if onSignup {
                        setUpDoneCell(cell)
                        cell.contentView.addSubview(loginIndicator)
                        cell.contentView.addSubview(doneText)
                    }
                }
            }
        }
        return Cell
    }
    
    func setUpNameCell(cell :UITableViewCell) {
        nameField.clearButtonMode = UITextFieldViewMode.WhileEditing
        nameField.textAlignment = NSTextAlignment.Center
        nameField.textColor = UIColor.whiteColor()
        nameField.attributedPlaceholder = NSAttributedString(string: "your name", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        nameField.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        nameField.frame = cell.frame
        nameField.autocorrectionType = UITextAutocorrectionType.No
    }
    
    // Format the password cell
    func setUpPasswordCell(cell : UITableViewCell) {
        passwordField.clearButtonMode = UITextFieldViewMode.WhileEditing
        passwordField.textAlignment = NSTextAlignment.Center
        passwordField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        passwordField.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        passwordField.frame = cell.frame
        passwordField.textColor = UIColor.whiteColor()
        passwordField.autocorrectionType = UITextAutocorrectionType.No
        passwordField.secureTextEntry = true
    }
    
    // Format the email cell when appropriate
    func setUpEmailCell(cell : UITableViewCell) {
        emailField.clearButtonMode = UITextFieldViewMode.WhileEditing
        emailField.textAlignment = NSTextAlignment.Center
        emailField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        emailField.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        emailField.frame = cell.frame
        emailField.textColor = UIColor.whiteColor()
        emailField.autocorrectionType = UITextAutocorrectionType.No
    }
    
    // Format city-picker cell
    func setUpCityPickerCell(cell: UITableViewCell) {
        cityField.text = cityText
        cityField.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        cityField.textAlignment = NSTextAlignment.Center
        
        let textSize = cityField.sizeThatFits(CGSize.zeroSize)
        cityField.frame = cell.frame
        
        if cityTextChanged {
            cityField.textColor = UIColor.whiteColor()
        } else {
            cityField.textColor = UIColor.lightGrayColor()
        }
    }
    
    // Format the done cell
    func setUpDoneCell(cell : UITableViewCell) {
        doneText.frame = cell.frame
        doneText.textColor = UIColor.whiteColor()
        doneText.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        doneText.text = doneString
        doneText.textAlignment = NSTextAlignment.Center
        
        let loginIndicatorSize = loginIndicator.frame.size.width
        loginIndicator.frame = CGRectMake((cell.frame.size.width - loginIndicatorSize)/2, 10, loginIndicatorSize, loginIndicatorSize)
    }
    
    
    
    
}
