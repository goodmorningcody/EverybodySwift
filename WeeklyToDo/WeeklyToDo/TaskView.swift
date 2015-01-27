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
    @IBOutlet var visualEffectView : UIVisualEffectView?
    
    @IBAction func touchedWeekendToggleButton(sender: UIButton) {
        sender.selected = !sender.selected
    }
    @IBAction func touchedClose(sender : UIButton) {
        hide()
    }
    
    @IBAction func touchedSet(sender : UIButton) {
        hide()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func hide() {
        UIView.animateWithDuration( 0.2, animations: {
                println("")
                self.visualEffectView?.alpha = 0.0
            }, completion: { finished in
                self.removeFromSuperview()
            }
        )
    }
    
    func show(parent: UIView) {
        self.visualEffectView?.alpha = 0.0
        var originalTransform = self.transform
        self.transform = CGAffineTransformMakeTranslation(self.transform.tx, bounds.height)
        parent.addSubview(self)
        
        UIView.animateWithDuration(0.4, delay:0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.2, options:UIViewAnimationOptions.CurveEaseIn, animations: {
            println("") // for compile error T_T
            self.visualEffectView?.alpha = 0.8
            self.transform = originalTransform
            }, completion: { finished in
                //self.removeFromSuperview()
        })
    }
}
