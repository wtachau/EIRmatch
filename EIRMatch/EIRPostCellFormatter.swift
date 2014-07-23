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
                var name = UITextField()
                name.userInteractionEnabled = true
                name.attributedPlaceholder = NSAttributedString(string: "what's your name?", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
                
                name.font = UIFont(name: "HelveticaNeue-Light", size: 16)
                let textSize = name.sizeThatFits(CGSize.zeroSize)
                name.frame = CGRectMake(sideBuffer, topBuffer, cell.frame.size.width, textSize.height)
                name.textColor = UIColor.whiteColor()
                name.autocorrectionType = UITextAutocorrectionType.No
                cell.contentView.addSubview(name)
            } else {
                var office = UILabel()
                office.text = cityText
                office.font = UIFont(name: "HelveticaNeue-Light", size: 16)
                
                let textSize = office.sizeThatFits(CGSize.zeroSize)
                office.frame = CGRectMake(sideBuffer, topBuffer, textSize.width, textSize.height)
                
                if cityTextChanged {
                    office.textColor = UIColor.whiteColor()
                } else {
                    office.textColor = UIColor.lightGrayColor()
                }
                
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                cell.contentView.addSubview(office)
            }
        }
        
        return Cell
    }
    
    // Get the middle cells in the Post view controller
    func setUpMidCell(indexPath: NSIndexPath) -> UITableViewCell! {
        var Cell : UITableViewCell?
        Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        if let cell = Cell  {
            
            cell.backgroundColor = buttonColor
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            var choiceSwitch = UISwitch()
            let scale = Float(0.7)
            choiceSwitch.transform = CGAffineTransformMakeScale(scale, scale)
            let switchSize: CGSize = choiceSwitch.sizeThatFits(CGSize.zeroSize)
            choiceSwitch.frame = CGRectMake(cell.bounds.size.width - switchSize.width,
                (cell.bounds.size.height - switchSize.height) / 2.0,
                switchSize.width,
                switchSize.height)
            choiceSwitch.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin
            choiceSwitch.onTintColor = lightGreen
            cell.contentView.addSubview(choiceSwitch)
            
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
                var title = UITextField()
                title.attributedPlaceholder = NSAttributedString(string: "title", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
                
                title.font = UIFont(name: "HelveticaNeue-Light", size: 16)
                let textSize = title.sizeThatFits(CGSize.zeroSize)
                title.frame = CGRectMake(sideBuffer, topBuffer, cell.frame.size.width, textSize.height)
                title.textColor = UIColor.whiteColor()
                title.autocorrectionType = UITextAutocorrectionType.No
                cell.contentView.addSubview(title)
            } else {
                var desc = UITextView()
                desc.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
                let descSize = desc.sizeThatFits(CGSize.zeroSize)
                desc.frame = CGRectMake(0, 0, cell.frame.size.width, descHeight)
                desc.textColor = UIColor.whiteColor()
                desc.backgroundColor = buttonColor
                
                //hide separator
                cell.separatorInset = UIEdgeInsets(top: 0.0, left: cell.bounds.size.width, bottom: 0.0, right: 0)
                
                cell.contentView.addSubview(desc)
            }
        }
        return Cell
    }
    
}
