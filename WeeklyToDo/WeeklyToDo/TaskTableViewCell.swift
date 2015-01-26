//
//  TaskTableViewCell.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 22..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit

@objc protocol TaskTableViewCellProtocol {
    optional func taskTableViewCell(#done:Bool, trach:Bool)
}

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet var taskLabel : UILabel?
    @IBOutlet var checkboxButton : UIButton?
    @IBOutlet var trashButton : UIButton?
    @IBOutlet var delegate : TaskTableViewCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
//    func done(done: Bool) {
//        checkboxButton?.selected = !done
//        trashButton?.hidden = !done
//        
//        
//        if done==true {
//            taskLabel?.textColor = Color.getDoneTaskTextColor()
//        }
//        else {
//            taskLabel?.textColor = Color.getTaskTextColor()
//        }
//    }

}
