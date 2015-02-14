//
//  TaskViewController.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 27..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit
import CoreData

@objc protocol TaskViewProtocol {
    optional func didAddingToDo()
}


class TaskView: UIView, UITextFieldDelegate {
    
    @IBOutlet var taskTextField : UITextField?
    @IBOutlet var addOrEditButton : UIButton?
    @IBOutlet var weekendButtonArray : [UIButton]?
    @IBOutlet var todayImageArray : [UIImageView]?
    
    @IBOutlet var repeatSegment : UISegmentedControl?
    @IBOutlet var visualEffectView : UIVisualEffectView?
    
    var delegate : TaskViewProtocol?
    
    var isOverwrite : Bool?
    var overwriteWeekend : Int?
    var overwriteIndexAtWeekend : Int?
    
    @IBAction func touchedWeekendToggleButton(sender: UIButton) {
        sender.selected = !sender.selected
    }
    @IBAction func touchedClose(sender : UIButton) {
        hide()
    }
    
    @IBAction func touchedSet(sender : UIButton) {

        var selectedWeekendArray : [Int] = [Int]()
        var button : UIButton?
        for( var i=0; i<weekendButtonArray?.count; ++i ) {
            button = weekendButtonArray?[i]
            if button?.selected==true {
                selectedWeekendArray.append(button!.tag)
            }
        }
        
        if selectedWeekendArray.count==0 {
            UIAlertView(title: "Weekly To-Do", message: "Please select a weekend", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        
        if let inputedToDo = taskTextField?.text {
            if countElements(inputedToDo)==0 {
                UIAlertView(title: "Weekly To-Do", message: "Please input To-Do description.", delegate: nil, cancelButtonTitle: "OK").show()
                return
            }
            
            for selectedWeekend in selectedWeekendArray {
                if isOverwrite==true {
                    WeeklyToDoDB.sharedInstance.updateTaskInWeekend(overwriteWeekend!, atIndex: overwriteIndexAtWeekend!, todo: inputedToDo, isRepeat: repeatSegment?.selectedSegmentIndex==0 ? true : false)
                }
                else {
                    WeeklyToDoDB.sharedInstance.insertTaskInWeekend(inputedToDo, when: Weekly.weekday(selectedWeekend, useStandardFormat:true), isRepeat: repeatSegment?.selectedSegmentIndex==0 ? true : false)
                }
                
            }
            
            hide()
            delegate?.didAddingToDo?()
        }
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
    
    func show(parent: UIView, weekend:Int, index:Int) {
        isOverwrite = true
        overwriteWeekend = weekend
        overwriteIndexAtWeekend = index
        
        self.addOrEditButton?.setTitle("EDIT", forState: UIControlState.Normal)
        self.addOrEditButton?.setTitle("EDIT", forState: UIControlState.Highlighted)
        
        if let task = WeeklyToDoDB.sharedInstance.taskInWeekend(weekend, atIndex:index) {
            self.taskTextField?.text = task.todo
            self.repeatSegment?.selectedSegmentIndex = task.repeat.boolValue==true ? 0:1
            var dateFormatter = NSDateFormatter()
            for( var i=0; i<dateFormatter.weekdaySymbols.count; ++i ) {
                self.weekendButtonArray?[i].selected = dateFormatter.weekdaySymbols[i] as String == Weekly.weekdayFromNow(weekend, useStandardFormat: true)
                self.weekendButtonArray?[i].userInteractionEnabled = false
            }
        }
        
        self.visualEffectView?.alpha = 0.0
        var originalTransform = self.transform
        self.transform = CGAffineTransformMakeTranslation(self.transform.tx, bounds.height)
        parent.addSubview(self)
        
        UIView.animateWithDuration(0.5, delay:0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options:UIViewAnimationOptions.CurveEaseIn, animations: {
            self.visualEffectView?.alpha = 1.0
            self.transform = originalTransform
            },
            completion: { finished in
            }
        )
        
    }
    func show(parent: UIView) {
        isOverwrite = false
        
        self.addOrEditButton?.setTitle("ADD", forState: UIControlState.Normal)
        self.addOrEditButton?.setTitle("ADD", forState: UIControlState.Highlighted)
        
        self.taskTextField?.text = ""
        self.repeatSegment?.selectedSegmentIndex = 0
        
        var dateFormatter = NSDateFormatter()
        for( var i=0; i<dateFormatter.weekdaySymbols.count; ++i ) {
            self.weekendButtonArray?[i].selected = dateFormatter.weekdaySymbols[i] as String == Weekly.weekdayFromNow(0, useStandardFormat: true)
            self.weekendButtonArray?[i].userInteractionEnabled = true
        }
        
        self.visualEffectView?.alpha = 0.0
        var originalTransform = self.transform
        self.transform = CGAffineTransformMakeTranslation(self.transform.tx, bounds.height)
        parent.addSubview(self)
        
        UIView.animateWithDuration(0.5, delay:0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options:UIViewAnimationOptions.CurveEaseIn, animations: {
            self.visualEffectView?.alpha = 1.0
            self.transform = originalTransform
            },
            completion: { finished in
            }
        )
    }
    
}
