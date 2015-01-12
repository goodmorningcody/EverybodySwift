//
//  TooDoMainViewController.swift
//  TooDo
//
//  Created by Cody on 2015. 1. 13..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit
import QuartzCore

class TooDoMainViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var myMessageTextField : UITextField?
    @IBOutlet var createToDoView : CreateToDoView?
    private var dialogBackgroundGrayView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        dialogBackgroundGrayView = UIView(frame: self.view.frame)
        dialogBackgroundGrayView?.backgroundColor = UIColor.blackColor()
        dialogBackgroundGrayView?.alpha = 0.3
        dialogBackgroundGrayView?.hidden = true
        self.view.addSubview(dialogBackgroundGrayView!)
        
        self.view.bringSubviewToFront(createToDoView!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let settedMyMessage = DataController.sharedInstance.myMessage() {
            myMessageTextField?.text = settedMyMessage
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        DataController.sharedInstance.setMyMessage(textField.text)
        return true;
    }
    
    @IBAction func touchedAdd(sender: UIButton) {
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategorieCellIdentifier", forIndexPath: indexPath) as UITableViewCell
        if let label = cell.viewWithTag(101) as? UILabel {
            label.text = "Cody"
        }
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //dialogBackgroundGrayView?.
//        UIView.animateWithDuration(0.7, animations: { () -> Void in
//            self.dialogBackgroundGrayView?.hidden = true
//        })
    }

}
