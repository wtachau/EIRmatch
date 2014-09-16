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
  var keyboardShowing = false
  
  init(loginController : EIRLoginController) {
    self.loginController = loginController
  }
  
  func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    
    //since uitextfields prevent this method from being called, always call hide keyboard from here
    hideKeyboard()
    
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
      }
    }
  }
  
  func showKeyboard() {
    if !keyboardShowing {
      emptyCells -= 2
      if let login = loginController {
        login.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0), NSIndexPath(forRow: 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Top)
      }
    }
    keyboardShowing = true
    
  }
  
  func hideKeyboard() {
    if keyboardShowing {
      if let login = loginController {
        emptyCells += 2
        login.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0), NSIndexPath(forRow: 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Top)
        login.tableView.endEditing(true)
      }
    }
    keyboardShowing = false
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
