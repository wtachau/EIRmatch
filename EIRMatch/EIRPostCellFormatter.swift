//
//  EIRPostCellFormatter.swift
//  EIRMatch
//
//  Created by William Tachau on 7/23/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

// Set up cells
extension EIRPostController {
    
    // Get the middle cells in the Post view controller
    func setUpTopCell(indexPath: NSIndexPath) -> UITableViewCell! {
        var Cell : UITableViewCell?
        Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        // Customize cell
        if let cell = Cell  {
            
            cell.backgroundColor = buttonColor
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if indexPath.row == 0 {
                
                nameField.userInteractionEnabled = true
                nameField.attributedPlaceholder = NSAttributedString(string: "what's your name?", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
                
                nameField.font = UIFont(name: "HelveticaNeue-Light", size: 16)
                let textSize = nameField.sizeThatFits(CGSize.zeroSize)
                nameField.frame = CGRectMake(sideBuffer, topBuffer, cell.frame.size.width, textSize.height)
                nameField.textColor = UIColor.whiteColor()
                nameField.autocorrectionType = UITextAutocorrectionType.No
                cell.contentView.addSubview(nameField)
            } else {
                var cityField = UILabel()
                cityField.text = cityText
                cityField.font = UIFont(name: "HelveticaNeue-Light", size: 16)
                
                let textSize = cityField.sizeThatFits(CGSize.zeroSize)
                cityField.frame = CGRectMake(sideBuffer, topBuffer, textSize.width, textSize.height)
                
                if cityTextChanged {
                    cityField.textColor = UIColor.whiteColor()
                } else {
                    cityField.textColor = UIColor.lightGrayColor()
                }
                
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                cell.contentView.addSubview(cityField)
            }
        }
        
        return Cell
    }
    
    // Get the middle cells in the Post view controller
    func setUpMidCell(indexPath: NSIndexPath) -> UITableViewCell! {
        var Cell : UITableViewCell?
        Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        if let cell = Cell  {
            
            var role : Role = {
                switch indexPath.row {
                case 0:
                    return .Management
                case 1:
                    return .Developer
                default:
                    return .Design
                }
            }()
            
            needs[role]!.transform = CGAffineTransformMakeScale(0.75, 0.75)
            
            cell.backgroundColor = buttonColor
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            let scale = Float(0.7)
            needs[role]!.transform = CGAffineTransformMakeScale(scale, scale)
            let switchSize: CGSize = needs[role]!.sizeThatFits(CGSize.zeroSize)
            needs[role]!.frame = CGRectMake(cell.bounds.size.width - switchSize.width,
                (cell.bounds.size.height - switchSize.height) / 2.0,
                switchSize.width,
                switchSize.height)
            needs[role]!.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin
            needs[role]!.onTintColor = lightGreen
            cell.contentView.addSubview(needs[role]!)
            
            var label = UILabel()
            label.textColor = UIColor.whiteColor()
            label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
            switch indexPath.row {
            case 0:
                label.text = "management"
            case 1:
                label.text = "developers"
            default:
                label.text = "designers"
            }
            let labelSize = label.sizeThatFits(CGSize.zeroSize)
            label.frame = CGRectMake(sideBuffer, topBuffer, labelSize.width, labelSize.height)
            cell.contentView.addSubview(label)
        }
        return Cell
    }
    
    
    // Get the bottom most cells in the Post view controller
    func setUpDescCell(indexPath: NSIndexPath) -> UITableViewCell! {
        
        var Cell : UITableViewCell?
        
        Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        // Customize cell
        if let cell = Cell  {
            
            cell.backgroundColor = buttonColor
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if indexPath.row == 0 {
                postTitle.attributedPlaceholder = NSAttributedString(string: "title", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
                
                postTitle.font = UIFont(name: "HelveticaNeue-Light", size: 16)
                let textSize = postTitle.sizeThatFits(CGSize.zeroSize)
                postTitle.frame = CGRectMake(sideBuffer, topBuffer, cell.frame.size.width, textSize.height)
                postTitle.textColor = UIColor.whiteColor()
                postTitle.autocorrectionType = UITextAutocorrectionType.No
                cell.contentView.addSubview(postTitle)
            } else {
                postDesc.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
                let descSize = postDesc.sizeThatFits(CGSize.zeroSize)
                postDesc.frame = CGRectMake(0, 0, cell.frame.size.width, descHeight)
                postDesc.textColor = UIColor.whiteColor()
                postDesc.backgroundColor = buttonColor
                
                //hide separator
                cell.separatorInset = UIEdgeInsets(top: 0.0, left: cell.bounds.size.width, bottom: 0.0, right: 0)
                
                cell.contentView.addSubview(postDesc)
            }
        }
        return Cell
    }
    
}
