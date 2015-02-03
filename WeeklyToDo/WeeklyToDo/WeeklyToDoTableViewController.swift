//
//  WeeklyToDoTableViewController.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 22..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit

class WeeklyToDoTableViewController: UITableViewController, TaskTableViewCellProtocol {

    var taskViewController : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = Color.getNavigationBackgroundColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:Color.getPointColor(), NSFontAttributeName : Font.getHightlightFont()]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add"), style: UIBarButtonItemStyle.Plain, target: self, action: "addNewTask")
        self.navigationItem.rightBarButtonItem?.tintColor = Color.getPointColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged:", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func orientationChanged(notification: NSNotification) {
        if let viewController = taskViewController {
            viewController.view.center = CGPointMake(UIScreen.mainScreen().bounds.size.width/2, UIScreen.mainScreen().bounds.size.height/2)
            viewController.view.bounds = UIScreen.mainScreen().bounds
        }
    }
    
    func addNewTask() {
        if taskViewController == nil  {
            taskViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TaskViewIdentifier") as? UIViewController
        }
        
        if let rootView = self.navigationController?.view {
            if let taskView = taskViewController!.view as? TaskView {
                taskView.show(rootView)
            }
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
        return WeeklyToDoDB.sharedInstance.countOfTaskInWeekend(section) + 1
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
        taskCell.tableView = self.tableView
        
        if let task = WeeklyToDoDB.sharedInstance.taskInWeekend(indexPath.section, atIndex: indexPath.row-1) {
            taskCell.todo = task.todo
            taskCell.done = task.done.boolValue
        }
        
        return taskCell
    }
    private func updateWeekendCell(cell: UITableViewCell, withIndexPath  indexPath : NSIndexPath) -> WeekendTableViewCell {
        var weekendCell = cell as WeekendTableViewCell
        
        // depthImageView는 셀을 클릭할 때 확장할 수 있는 구조로 변경해야 합니다.
        if WeeklyToDoDB.sharedInstance.countOfTaskInWeekend(indexPath.section) > 0 {
            weekendCell.depthImageView?.hidden = false
        }
        else {
            weekendCell.depthImageView?.hidden = true
        }
        
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
    
    func taskTableViewCell(#done: Bool, trash: Bool, indexPath:NSIndexPath) {
        if done==true {
            WeeklyToDoDB.sharedInstance.switchDoneTaskInWeekend(indexPath.section, atIndex: indexPath.row-1)
        }
        else if trash==true {
            WeeklyToDoDB.sharedInstance.removeTaskInWeekend(indexPath.section, atIndex: indexPath.row-1)
        }
        
        self.tableView.reloadData()
    }
}
