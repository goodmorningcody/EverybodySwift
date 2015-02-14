//
//  WeeklyToDoTableViewController.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 22..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit

class WeeklyToDoTableViewController: UITableViewController, TaskTableViewCellProtocol, TaskViewProtocol {

    var taskViewController : UIViewController?
    var timer : NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = Color.getNavigationBackgroundColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:Color.getPointColor(), NSFontAttributeName : Font.getHightlightFont()]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add"), style: UIBarButtonItemStyle.Plain, target: self, action: "addNewTask")
        self.navigationItem.rightBarButtonItem?.tintColor = Color.getPointColor()
        
        WeeklyToDoDB.sharedInstance.needUpdate()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("orientationChanged"), name: UIDeviceOrientationDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("willEnterForrground"), name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("didEnterBackground"), name: UIApplicationDidEnterBackgroundNotification, object: nil)
        
        setUpdateScheduler()
    }
    func didEnterBackground() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    func willEnterForrground() {
        setUpdateScheduler()
    }
    func setUpdateScheduler() {
        let components = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond, fromDate: NSDate())
        
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }

        var afterSeconds = Double(((24-components.hour)*60*60)-(components.minute*60)-(components.second))
        timer = NSTimer.scheduledTimerWithTimeInterval(afterSeconds, target: self, selector: Selector("needUpdate"), userInfo: nil, repeats: false)
    }
    func needUpdate() {
        println("needUpdate")
        WeeklyToDoDB.sharedInstance.needUpdate()
        tableView?.reloadData()
        setUpdateScheduler()
    }
    
    func orientationChanged() {
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
                taskView.delegate = self
                taskView.show(rootView)
            }
        }
    }
    
    func didAddingToDo() {
        tableView.reloadData()
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
        // 업데이트 로직을 cell 객체로 이동
        var taskCell = cell as TaskTableViewCell
        taskCell.delegate = self
        taskCell.tableView = self.tableView
        
        if let task = WeeklyToDoDB.sharedInstance.taskInWeekend(indexPath.section, atIndex: indexPath.row-1) {
            taskCell.todo = task.todo
            taskCell.done = task.done.boolValue
            taskCell.repeat = task.repeat.boolValue
        }
        
        return taskCell
    }
    private func updateWeekendCell(cell: UITableViewCell, withIndexPath  indexPath : NSIndexPath) -> WeekendTableViewCell {
        // 업데이트 로직을 cell 객체로 이동
        var weekendCell = cell as WeekendTableViewCell
        if WeeklyToDoDB.sharedInstance.countOfTaskInWeekend(indexPath.section) > 0 {
            weekendCell.depthImageView?.hidden = false
        }
        else {
            weekendCell.depthImageView?.hidden = true
        }
        
        weekendCell.todayMarkView?.hidden = (indexPath.section != 0)
        weekendCell.weekendLabel?.text = Weekly.weekdayFromNow(indexPath.section, useStandardFormat: false)
        
        var countOfTask = WeeklyToDoDB.sharedInstance.countOfTaskInWeekend(indexPath.section)
        var countOfDoneTask = WeeklyToDoDB.sharedInstance.countOfDoneTaskInWeekend(indexPath.section)
        
        if countOfTask>0 {
            weekendCell.countLabel?.hidden = false
            weekendCell.countLabel?.text = String(countOfDoneTask)+"/"+String(countOfTask)
        }
        else {
            weekendCell.countLabel?.hidden = true
        }
        
        return weekendCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row==0 {
            return 58.0
        }
        return 44.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row==0 {
            return
        }
        
        if taskViewController == nil  {
            taskViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TaskViewIdentifier") as? UIViewController
        }
        
        if let rootView = self.navigationController?.view {
            if let taskView = taskViewController!.view as? TaskView {
                taskView.delegate = self
                taskView.show(rootView, weekend: indexPath.section, index: indexPath.row-1)
            }
        }
    }
    
    func taskTableViewCell(#done: Bool, trash: Bool, repeat: Bool, indexPath:NSIndexPath) {
        if done==true {
            WeeklyToDoDB.sharedInstance.switchDoneTaskInWeekend(indexPath.section, atIndex: indexPath.row-1)
        }
        else if trash==true {
            WeeklyToDoDB.sharedInstance.removeTaskInWeekend(indexPath.section, atIndex: indexPath.row-1)
        }
        else if repeat==true {
            WeeklyToDoDB.sharedInstance.switchRepeatOptionInWeekend(indexPath.section, atIndex: indexPath.row-1)
        }
        
        self.tableView.reloadData()
    }
}
