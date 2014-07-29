//
//  EIRLoginHelper.swift
//  EIRMatch
//
//  Created by William Tachau on 7/28/14.
//  Copyright (c) 2014 William Tachau. All rights reserved.
//

import UIKit

class EIRLoginHelper : NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var loginController : EIRLoginController?
    var emptyCells = 2
    
    init(loginController : EIRLoginController) {
        self.loginController = loginController
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        // First assert loginController is set
        if let login = loginController {
        
            // User selects city picker cell (only on signup)
            if indexPath.row == (emptyCells + 4) && login.onSignup {
                login.navigationController.pushViewController(login.cityPicker, animated: true)
                login.cityTextChanged = true
            // User selects "done"
            } else if indexPath.row == (emptyCells + login.numActiveCells + 1) {
                // login
                login.doneString = ""
                login.tableView.reloadData()
                login.loginIndicator.startAnimating()
                login.onSignup ? login.trySignup() : login.tryLogin()
                
            // User toggles signup/ login
            } else if indexPath.row == emptyCells {
                login.onSignup = !login.onSignup
                login.numActiveCells = login.onSignup ? 4 : 2
                login.onSignup ? emptyCells-- : emptyCells++
                login.tableView.reloadData()
            // Users selects one of the empty cells
            } else if (indexPath.row <= emptyCells || indexPath.row >= emptyCells + login.numActiveCells) {
                tableView.endEditing(true)
            }
        
        }
    
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return emptyCells + 6
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell : UITableViewCell?
        if let login = loginController {
            cell = login.setUpCell(indexPath.row - emptyCells)
        }
        return cell
    }
}
