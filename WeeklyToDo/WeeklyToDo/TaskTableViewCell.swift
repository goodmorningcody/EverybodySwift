//
//  TaskTableViewCell.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 22..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit

@objc protocol TaskTableViewCellProtocol {
    optional func taskTableViewCell(#done:Bool, trash:Bool, repeat:Bool, indexPath:NSIndexPath?)
}

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet var taskLabel : UILabel?
    @IBOutlet var checkboxButton : UIButton?
    @IBOutlet var trashButton : UIButton?
    @IBOutlet var repeatButton : UIButton?
    
    @IBOutlet var delegate : TaskTableViewCellProtocol?
    var tableView : UITableView?

    var repeat : Bool {
        get {
            return self.repeatButton!.selected
        }
        set {
            repeatButton!.selected = newValue
        }
    }
    
    var todo : String? {
        get {
            return self.taskLabel?.text
        }
        set {
            taskLabel?.text = newValue
        }
    }
    var done : Bool {
        get {
            return self.done
        }
        set {
            checkboxButton?.selected = !newValue
            trashButton?.hidden = !newValue
            repeatButton?.hidden = newValue
            
            if newValue==true {
                taskLabel?.textColor = Color.getDoneTaskTextColor()
            }
            else {
                taskLabel?.textColor = Color.getTaskTextColor()
            }
        }
    }
    
    @IBAction func touchedDone(sender : UIButton) {
        if let indexPathOfThisCell = tableView?.indexPathForCell(self) {
            delegate?.taskTableViewCell?(done: true, trash: false, repeat:false, indexPath:indexPathOfThisCell)
        }
    }
    
    @IBAction func touchedRepeat(sender: UIButton) {
        if let indexPathOfThisCell = tableView?.indexPathForCell(self) {
            delegate?.taskTableViewCell?(done: false, trash: false, repeat:true, indexPath:indexPathOfThisCell)
        }
    }
    
    @IBAction func touchedTrash(sender: UIButton) {
        if let indexPathOfThisCell = tableView?.indexPathForCell(self) {
            delegate?.taskTableViewCell?(done: false, trash: true, repeat:false, indexPath:indexPathOfThisCell)
        }
    }

}
