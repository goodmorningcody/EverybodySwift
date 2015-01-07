//
//  AccelerometerViewController.swift
//  SensorsDemo
//
//  Created by Cody on 2015. 1. 5..
//  Copyright (c) 2015년 tiekle. All rights reserved.
//

import UIKit
import CoreMotion

class AccelerometerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var motionManager = CMMotionManager()
        
        if motionManager.accelerometerAvailable==false {
            println("Accelerometer 센서를 사용할 수 없습니다.")
        }
        else {
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {(accelerometerData: CMAccelerometerData!, error: NSError!) in
                if error != nil {
                    println("x : "+accelerometerData.acceleration.x.description)
                    println("y : "+accelerometerData.acceleration.y.description)
                    println("z : "+accelerometerData.acceleration.z.description)
                }
            })
        }
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
