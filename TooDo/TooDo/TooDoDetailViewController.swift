//
//  TooDoDetailViewController.swift
//  TooDo
//
//  Created by Cody on 2015. 1. 15..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit

class TooDoDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView : UITableView?
    
    var category : String?
    private var dialogBackgroundGrayView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.title = category
        
        dialogBackgroundGrayView = UIView(frame: self.view.frame)
        dialogBackgroundGrayView?.backgroundColor = UIColor.blackColor()
        dialogBackgroundGrayView?.hidden = true
        self.view.addSubview(dialogBackgroundGrayView!)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("touchedAdd"))
    }
    
    func touchedAdd() {
    }
    private func todoInCateogory() -> [String]? {
        if let currentCategoryName = category {
            if let currentTodos = DataController.sharedInstance.todoInCategory(currentCategoryName) {
                return currentTodos
            }
        }
        return nil
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentTodos = todoInCateogory() {
            return currentTodos.count
        }
        
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoCellIdentifier", forIndexPath: indexPath) as UITableViewCell

        if let currentTodos = todoInCateogory() {
            cell.textLabel?.text = currentTodos[indexPath.row]
        }
        
        return cell
    }
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        return "Done"
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            DataController.sharedInstance.removeTodo(indexPath.row, category: category!)
            tableView.reloadData()
        }
    }
}
