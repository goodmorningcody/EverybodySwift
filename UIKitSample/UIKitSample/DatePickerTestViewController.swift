//
//  DatePickerTestViewController.swift
//  UIKitSample
//
//  Created by Cody on 2014. 12. 27..
//  Copyright (c) 2014년 tiekle. All rights reserved.
//

import UIKit

class DatePickerTestViewController: UIViewController {

    @IBAction func changedDateValue(sender: UIDatePicker) {
//        var alert = UIAlertController(title: "UIDatePicker", message: sender.date.description, preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "확인", style: .Default, handler: { action in
//        }))
//        presentViewController(alert, animated: true, completion: nil)
        var alert = UIAlertView(title: "UIDatePicker", message: sender.date.description, delegate: nil, cancelButtonTitle: "확인")
        alert.show()
        //sender.date.
        var settedDate : NSDate = sender.date
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
