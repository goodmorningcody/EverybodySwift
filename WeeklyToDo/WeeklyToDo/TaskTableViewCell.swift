//
//  TaskTableViewCell.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 22..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet var taskLabel : UILabel?
    @IBOutlet var checkboxButton : UIButton?
    @IBOutlet var trashButton : UIButton?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func doneToDo(done: Bool) {
        checkboxButton?.selected != done
        trashButton?.hidden != done
    }

}
