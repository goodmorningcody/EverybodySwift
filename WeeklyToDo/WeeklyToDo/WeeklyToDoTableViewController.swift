//
//  WeeklyToDoTableViewController.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 22..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit

class WeeklyToDoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for( var i : Int = 0; i<7; ++i ) {
            println(Weekly.weekday(i))
        }
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 249.0/255.0, green: 179.0/255.0, blue: 16.0/255.0, alpha: 1)
        var font = UIFont(name: "Helvetica Bold", size: 22.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),  NSFontAttributeName : font!]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.tableView?.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
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
        return 2
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
        return taskCell
    }
    private func updateWeekendCell(cell: UITableViewCell, withIndexPath  indexPath : NSIndexPath) -> WeekendTableViewCell {
        var weekendCell = cell as WeekendTableViewCell
//        if indexPath.section == 0 {
//            weekendCell.shadowImageView?.hidden = true
//        }
        weekendCell.shadowImageView?.hidden = indexPath.section == 0
        
        return weekendCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row==0 {
            return 69.0
        }
        return 55.0
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
