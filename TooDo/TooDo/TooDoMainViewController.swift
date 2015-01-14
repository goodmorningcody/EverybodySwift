//
//  TooDoMainViewController.swift
//  TooDo
//
//  Created by Cody on 2015. 1. 13..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit
import QuartzCore

let TAG_OF_TODOS_CATEGORY   = 101
let TAG_OF_TODOS_COUNT      = 102

class TooDoMainViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, CreateToDoViewDelegate {

    @IBOutlet var myMessageTextField : UITextField?
    @IBOutlet var createToDoView : CreateToDoView?
    @IBOutlet var todoTableView : UITableView?
    
    private var dialogBackgroundGrayView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let settedMyMessage = DataController.sharedInstance.myMessage() {
            myMessageTextField?.text = settedMyMessage
        }
        
        dialogBackgroundGrayView = UIView(frame: self.view.frame)
        dialogBackgroundGrayView?.backgroundColor = UIColor.blackColor()
        dialogBackgroundGrayView?.hidden = true
        self.view.addSubview(dialogBackgroundGrayView!)
        
        self.view.bringSubviewToFront(createToDoView!)
        createToDoView?.hidden = true
        createToDoView?.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        todoTableView?.reloadData()

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
        UIView.animateWithDuration(Double(0.4), animations: { () -> Void in
            self.dialogBackgroundGrayView?.hidden = false
            self.createToDoView?.hidden = false
            self.dialogBackgroundGrayView?.alpha = 0.0
            self.dialogBackgroundGrayView?.alpha = 0.4
        })
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let categories = DataController.sharedInstance.categories() {
            return categories.count
        }
        
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategorieCellIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        if let categories = DataController.sharedInstance.categories() {
            var category = categories[indexPath.row]
            if let label = cell.viewWithTag(TAG_OF_TODOS_CATEGORY) as? UILabel {
                label.text = category
            }
            
            if let todos = DataController.sharedInstance.todoInCategory(category) {
                if let countLabel = cell.viewWithTag(TAG_OF_TODOS_COUNT) as? UILabel {
                    countLabel.text = todos.count.description
                }
            }
        }
        
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToDoSegueIdentifier" {
            if let detailViewController = segue.destinationViewController as? TooDoDetailViewController {
                detailViewController.category = sender as? String
            }
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let categories = DataController.sharedInstance.categories() {
            self.performSegueWithIdentifier("ToDoSegueIdentifier", sender:categories[indexPath.row])
        }    
    }
    func didHidden(createToDoView: CreateToDoView) {
        UIView.animateWithDuration(Double(0.4), animations: { () -> Void in
            self.dialogBackgroundGrayView?.hidden = true
            self.createToDoView?.hidden = true
            self.todoTableView?.reloadData()
        })
    }

}
