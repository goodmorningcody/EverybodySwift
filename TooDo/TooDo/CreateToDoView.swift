//
//  CreateToDoView.swift
//  TooDo
//
//  Created by Cody on 2015. 1. 13..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit
import Foundation

@objc protocol CreateToDoViewDelegate {
    optional func didHidden(createToDoView: CreateToDoView)
}

class CreateToDoView: UIView {
    
    var delegate : CreateToDoViewDelegate?
    
    private func close() {
        delegate?.didHidden?(self)
    }
    
    @IBAction func touchedCancel(sender: UIButton) {
        close()
    }
    
    @IBAction func touchedAdd(sender: UIButton) {
        close()
    }

}
