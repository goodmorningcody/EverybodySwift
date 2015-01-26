//
//  WeeklyToDoTableViewController.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 22..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit

class WeeklyToDoTableViewController: UITableViewController, TaskTableViewCellProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = Color.getNavigationBackgroundColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:Color.getPointColor(), NSFontAttributeName : Font.getHightlightFont()]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add"), style: UIBarButtonItemStyle.Plain, target: self, action: "addNewTask")
        self.navigationItem.rightBarButtonItem?.tintColor = Color.getPointColor()
    }
    
    func addNewTask() {
        if let taskViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TaskViewControllerIdentifier") as? TaskViewController {
            self.navigationController?.view.addSubview(taskViewController.view)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TaskSegueIdentifier" {
            println("Create or Edit Task")
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 7
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var symbolInSection = Weekly.weekdayFromNow(section, useStandardFormat: true)
        return WeeklyToDoDB.sharedInstance.countOftaskInWeekend(symbolInSection) + 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellIdentifier : String?
        
        if indexPath.row==0 {
            cellIdentifier = "WeekendTableViewCellIdentifier"
        }
        else {
            cellIdentifier = "TaskTableViewCellIdentifier"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier!, forIndexPath: indexPath) as UITableViewCell
        if indexPath.row == 0 {
            return updateWeekendCell(cell, withIndexPath: indexPath)
        }
        
        return updateTaskCell(cell, withIndexPath: indexPath)
    }
    
    private func updateTaskCell(cell: UITableViewCell, withIndexPath indexPath : NSIndexPath) -> TaskTableViewCell {
        var taskCell = cell as TaskTableViewCell
        taskCell.delegate = self
        
        if indexPath.row==1 {
            taskCell.done = false
        }
        else if indexPath.row==2 {
            taskCell.done = true
        }
        
        return taskCell
    }
    private func updateWeekendCell(cell: UITableViewCell, withIndexPath  indexPath : NSIndexPath) -> WeekendTableViewCell {
        var weekendCell = cell as WeekendTableViewCell
        
        // It'is test
        // depthImageView는 셀을 클릭할 때 확장할 수 있는 구조로 변경해야 합니다.
        weekendCell.depthImageView?.hidden = (indexPath.section != 0)
        
        
        // for displaying weekend symbol
        weekendCell.todayMarkView?.hidden = (indexPath.section != 0)
        weekendCell.weekendLabel?.text = Weekly.weekdayFromNow(indexPath.section, useStandardFormat: false)
        
        return weekendCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row==0 {
            return 58.0
        }
        return 44.0
    }
    
    func taskTableViewCell(#done: Bool, trach: Bool) {
        println("taskTableViewCell in WeeklyToDoTableViewController")
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
}
