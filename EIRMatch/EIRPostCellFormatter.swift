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
    func setUpMidCell(indexPath: NSIndexPath) -> UITableViewCell! {
        var Cell : UITableViewCell?
        Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        if let cell = Cell  {
            
            // need ! to guarantee that role exists
            var role = Role.fromRaw(indexPath.row)!
            
            // here we need ! to guarantee that dict value exists
            needs[role]!.transform = CGAffineTransformMakeScale(0.75, 0.75)
            cell.backgroundColor = buttonColor
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            let scale = CGFloat(0.7)
            needs[role]!.transform = CGAffineTransformMakeScale(scale, scale)
            let switchSize: CGSize = needs[role]!.sizeThatFits(CGSize.zeroSize)
            needs[role]!.frame = CGRectMake(cell.bounds.size.width - switchSize.width,
                (cell.bounds.size.height - switchSize.height) / 2.0,
                switchSize.width,
                switchSize.height)
            needs[role]!.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin
            needs[role]!.onTintColor = lightGreen
            cell.contentView.addSubview(needs[role]!)
            
            // format text in cell
            var label = UILabel()
            label.textColor = UIColor.whiteColor()
            label.font = UIFont(name: "HelveticaNeue-Light", size: 16)
            label.text = role.string().lowercaseString
            let labelSize = label.sizeThatFits(CGSize.zeroSize)
            label.frame = CGRectMake(sideBuffer, topBuffer, labelSize.width, labelSize.height)
            cell.contentView.addSubview(label)
        }
        return Cell
    }
    
    
    // Set up the title/description cells in the Post view controller
    func setUpDescCell(indexPath: NSIndexPath) -> UITableViewCell! {
        
        var Cell : UITableViewCell?
        
        Cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        // Customize cell
        if let cell = Cell  {
            
            cell.backgroundColor = buttonColor
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if indexPath.row == 0 {
                // title
                postTitle.attributedPlaceholder = NSAttributedString(string: "title", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
                
                postTitle.font = UIFont(name: "HelveticaNeue-Light", size: 16)
                let textSize = postTitle.sizeThatFits(CGSize.zeroSize)
                postTitle.frame = CGRectMake(sideBuffer, topBuffer, cell.frame.size.width, textSize.height)
                postTitle.textColor = UIColor.whiteColor()
                postTitle.autocorrectionType = UITextAutocorrectionType.No
                cell.contentView.addSubview(postTitle)
            } else {
                // description
                postDesc.font = UIFont(name: "HelveticaNeue-Light", size: 16.0)
                let descSize = postDesc.sizeThatFits(CGSize.zeroSize)
                postDesc.frame = CGRectMake(0, 0, cell.frame.size.width, descHeight)
                postDesc.textColor = UIColor.whiteColor()
                postDesc.backgroundColor = buttonColor
                let textBuffer = CGFloat(7.0)
                postDesc.textContainerInset = UIEdgeInsetsMake(textBuffer, textBuffer, textBuffer, textBuffer)
                cell.contentView.addSubview(postDesc)
            }
        }
        return Cell
    }
    
}
