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
    //optional func touched(#done:Bool, trash:Bool, indexPath:NSIndexPath?)
    optional func didAddingToDo()
}


class TaskView: UIView, UITextFieldDelegate {
    
    @IBOutlet var taskTextField : UITextField?
    @IBOutlet var weekendButtonArray : [UIButton]?
    @IBOutlet var repeatSegment : UISegmentedControl?
    @IBOutlet var visualEffectView : UIVisualEffectView?
    
    var delegate : TaskViewProtocol?
    
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
            println("선택된 weekend가 하나도 없습니다. 최소 하나는 선택되어야 합니다.")
            return
        }
        
        if let inputedToDo = taskTextField?.text {
            for selectedWeekend in selectedWeekendArray {
                
                WeeklyToDoDB.sharedInstance.insertTaskInWeekend(inputedToDo,
                    when: Weekly.weekday(selectedWeekend, useStandardFormat:true), isRepeat: repeatSegment?.selectedSegmentIndex==0 ? true : false)
            }
            
            hide()
            delegate?.didAddingToDo?()
        }
        else {
            println("To Do에 입력된 내용이 없습니다. 내용을 입력하지 않고는 생성할 수 없습니다. ")
            return
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
