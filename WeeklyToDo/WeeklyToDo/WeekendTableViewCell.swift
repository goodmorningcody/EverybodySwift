//
//  WeekendTableViewCell.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 22..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit

class WeekendTableViewCell: UITableViewCell {
    @IBOutlet var weekendLabel : UILabel?
    @IBOutlet var countLabel : UILabel?
    @IBOutlet var depthImageView : UIImageView?
    @IBOutlet var noDepthImageView : UIImageView?
    @IBOutlet var todayMarkView : UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
