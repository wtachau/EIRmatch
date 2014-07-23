//
//  EIRPostController.swift
//  EIRMatch
//
//  Created by William Tachau on 7/22/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRPostController : UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    // Used because height of description changes dynamically based on screen size
    var descHeight : Float = 0.0
    
    // City name class and delegate
    var cityPicker : EIRCityPicker?
    var cityPickerHelper : EIRCityPickerTableViewHelper?
    
    // Text view delegate
    var textDelegate : EIRPostTextDelegate?
    
    // Also changes dynamically (todo: will be part of tableview datasource)
    var cityText = "which office are you in?"
    var cityTextChanged = false
    
    let sideBuffer = Float(10)
    let topBuffer = Float(9)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityPicker = EIRCityPicker()
        cityPickerHelper = EIRCityPickerTableViewHelper(cityPicker: cityPicker!)
        
        // set up city picker classes
        cityPicker!.tableView.delegate = cityPickerHelper!
        cityPicker!.tableView.dataSource = cityPickerHelper!
        
        // set up text view delegate
        textDelegate = EIRPostTextDelegate(postController: self)
        
        // format the bottom of the table
        tableView.tableFooterView = UIView(frame: CGRect.zeroRect)
        tableView.backgroundColor = backgroundColor
        
        // to hide keyboard
        let tap = UITapGestureRecognizer(target: self, action: "tableTapped:")
        tableView.addGestureRecognizer(tap)
        
        // calculate height so bottom cell fills screen
        self.descHeight = view.bounds.size.height
                        - tableView.rectForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 2)).origin.y
                        - navigationController.navigationBar.bounds.size.height
        
        // add "done" button to upper right
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done,
                                                            target: self, action: "postProject:")
    }
    
    // Hide keyboard when tapping outside text field
    func tableTapped(recognizer : UITapGestureRecognizer) {
     
        let tapLocation = recognizer.locationInView(tableView)
        let indexPath = tableView.indexPathForRowAtPoint(tapLocation)
        
        if !indexPath {
            view.endEditing(true)
        } else if (indexPath.row == 1 && indexPath.section == 2)
            || (indexPath.section == 0 && indexPath.row == 1) { // todo needs to clear even when header selected
            recognizer.cancelsTouchesInView = false
        } else {
            view.endEditing(true)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        cityText = cityPicker!.chosenCity
        tableView.reloadData()
    }
    
    func postProject(AnyObject) {
        println("done")
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}

extension EIRPostController {
    
    // Number of rows per section
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 2
        }
    }
    
    // Number of sections
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 3
    }
    
    
    // Set background color
    override func tableView(tableView: UITableView!, willDisplayHeaderView view: UIView!, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.contentView.backgroundColor = backgroundColor
            header.textLabel.textColor = UIColor.whiteColor()
            header.textLabel.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        }
    }
    
    // Set heights for each header
    override func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    // Header titles
    override func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        switch section {
        case 0:
            return "about you"
        case 1:
            return "what do you need?"
        default:
            return "about your project:"
        }
    }
    
    // Set height of cells
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        let normal = Float(36)
        
        switch indexPath.section {
        case 0, 1:
            return normal
        default:
            if indexPath.row == 0 {
                return normal
            } else {
                return descHeight
            }
        }
    }
    
    
    // If office cell is selected
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        if indexPath.section == 0 && indexPath.row == 1 {
            //todo separate into delegates
            navigationController.pushViewController(cityPicker, animated: true)
            cityTextChanged = true
        }
    }
    
    // Customize each cell
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var Cell : UITableViewCell?
        
        switch indexPath.section {
            
        // Name and Office
        case 0:
            Cell = setUpTopCell(indexPath)
            
        // What Do You Need?
        case 1:
            Cell = setUpMidCell(indexPath)
            
        // About your project
        default:
            Cell = setUpDescCell(indexPath)
            
        }
        Cell!.userInteractionEnabled = true
        return Cell
    }
}



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
                
                // Done button that calls delegate method
                
                desc.delegate = textDelegate!
                desc.returnKeyType = UIReturnKeyType.Done
                
                //hide separator
                cell.separatorInset = UIEdgeInsets(top: 0.0, left: cell.bounds.size.width, bottom: 0.0, right: 0)
                
                cell.contentView.addSubview(desc)
            }
        }
        return Cell
    }
    
}







