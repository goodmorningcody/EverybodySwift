//
//  TaskTableViewCell.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 22..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit

@objc protocol TaskTableViewCellProtocol {
    optional func taskTableViewCell(#done:Bool, trach:Bool, indexPath:NSIndexPath?)
}

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet var taskLabel : UILabel?
    @IBOutlet var checkboxButton : UIButton?
    @IBOutlet var trashButton : UIButton?
    @IBOutlet var delegate : TaskTableViewCellProtocol?
    var tableView : UITableView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
            
            if newValue==true {
                taskLabel?.textColor = Color.getDoneTaskTextColor()
            }
            else {
                taskLabel?.textColor = Color.getTaskTextColor()
            }
        }
    }
    
    @IBAction func touchedDone(sender : UIButton) {
        //if let tableView = self.superview as? UITableView {
        if let indexPathOfThisCell = tableView?.indexPathForCell(self) {
            delegate?.taskTableViewCell?(done: true, trach: false, indexPath:indexPathOfThisCell)
        }

    }
    
    @IBAction func touchedTrash(sender: UIButton) {
        //if let tableView = self.superview as? UITableView {
            //var indexPathOfThisCell = tableView.indexPathForCell(self)
//            delegate?.taskTableViewCell?(done: false, trach: true, indexPath:nil)
        //}
    }

}
