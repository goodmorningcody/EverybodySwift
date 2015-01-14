//
//  CreateToDoView.swift
//  TooDo
//
//  Created by Cody on 2015. 1. 13..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit
import Foundation

let TAG_OF_CATEGORY_TEXT_FIELD = 101

@objc protocol CreateToDoViewDelegate {
    optional func didHidden(createToDoView: CreateToDoView)
    optional func touchedCategoryTextField(createToDoView: CreateToDoView)
}

class CreateToDoView: UIView, UITextFieldDelegate {
    
    var delegate : CreateToDoViewDelegate?
    
    @IBOutlet var categoryTextField : UITextField?
    @IBOutlet var todoTextField : UITextField?
    
    private func close() {
        delegate?.didHidden?(self)
        
        if categoryTextField?.isFirstResponder()==true {
           categoryTextField?.resignFirstResponder()
        }
        
        if todoTextField?.isFirstResponder()==true {
            todoTextField?.resignFirstResponder()
        }
        
    }
    
    @IBAction func touchedCancel(sender: UIButton) {
        close()
    }
    
    @IBAction func touchedAdd(sender: UIButton) {
        if DataController.sharedInstance.addCategory(categoryTextField!.text)==true {
            DataController.sharedInstance.addTodo(todoTextField!.text, category: categoryTextField!.text)
            close()
        }
        else {
            UIAlertView(title: "Too Do", message: "카테고리가 잘못되었습니다.", delegate: nil, cancelButtonTitle: "확인").show()
        }
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.tag == TAG_OF_CATEGORY_TEXT_FIELD {
            delegate?.touchedCategoryTextField?(self)
        }
        
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
