//
//  RegisterViewController.swift
//  UIKitSample
//
//  Created by Cody on 2014. 12. 15..
//  Copyright (c) 2014년 tiekle. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailTextField : UITextField?
    @IBOutlet var passwordTextField : UITextField?
    @IBOutlet var repasswordTextField : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var alertView = UIAlertView(title: "Swift", message: "Hello Swift", delegate: self, cancelButtonTitle: "확인")
        //alertView.show()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        var alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
//            switch action.style{
//            case .Default:
//                UIApplication.sharedApplication().openURL(NSURL(string:"http://daum.net")!)
//                println("default")
//                
//            case .Cancel:
//                
//                println("cancel")
//                
//            case .Destructive:
//                println("destructive")
//            }
//        }))
//        presentViewController(alert, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//    @IBAction func unwindFromAgreement(segue: UIStoryboardSegue) {
//        println("unwindFromAgreement")
//    }
    
    
    func alert(alertMessage: String) {
        var alertView = UIAlertView(title: "Swift", message: alertMessage, delegate: nil, cancelButtonTitle: "확인")
        alertView.show()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let length = countElements(textField.text)
        
        if length==0 {
            alert("텍스트를 입력해주세요.")
            return false
        }
        
        let inputedText = textField.text
        if textField==emailTextField {
            if inputedText.rangeOfString("@") != nil {
                passwordTextField?.becomeFirstResponder()
            }
            else {
                alert("이메일 포맷을 확인해주세요.")
                return false
            }
        }
        else if textField==passwordTextField {
            if length>=6 && length<=12 {
                repasswordTextField?.becomeFirstResponder()
            }
            else {
                alert("패스워드는 6에서 12자리 이내여야 합니다.")
                return false
            }
        }
        else if textField==repasswordTextField {
            if passwordTextField?.text==repasswordTextField?.text {
                alert("회원가입을 축하합니다.")
                textField.resignFirstResponder()
            }
            else {
                alert("패스워드가 일치하지 않습니다.")
                return false
            }
        }
        
        return true
    }
    
//    func alertViewCancel(alertView: UIAlertView) {
//        UIApplication.sharedApplication().openURL(NSURL(string:"http://daum.net")!)
//    }
    
}
