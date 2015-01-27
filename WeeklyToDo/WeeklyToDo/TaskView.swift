//
//  TaskViewController.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 27..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit

class TaskView: UIView, UITextFieldDelegate {
    
    var task : Task?
    
    @IBOutlet var taskTextField : UITextField?
    @IBOutlet var weekendToggleButton : Array<UIButton>?
    @IBOutlet var repeatSegment : UISegmentedControl?
    
    @IBAction func touchedWeekendToggleButton(sender: UIButton) {
        sender.selected = !sender.selected
    }
    @IBAction func touchedClose(sender : UIButton) {
        removeFromSuperview()
    }
    
    @IBAction func touchedSet(sender : UIButton) {
        removeFromSuperview()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
