//
//  LoginViewController.swift
//  UIKitSample
//
//  Created by Cody on 2014. 12. 25..
//  Copyright (c) 2014년 tiekle. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchedLogin(sender: UIButton) {
    }
    
    @IBAction func touchedSignup(sender: UIButton) {
    }
    
    @IBAction func unwindFromRegister(segue: UIStoryboardSegue) {
        println("unwindFromRegister")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
