//
//  GyroscopeViewController.swift
//  SensorsDemo
//
//  Created by Cody on 2015. 1. 5..
//  Copyright (c) 2015년 tiekle. All rights reserved.
//

import UIKit
import CoreMotion

class GyroscopeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var motionManager = CMMotionManager()
        if motionManager.gyroAvailable==false {
            println("Gyroscopre 센서를 사용할 수 없습니다.")
        }
        else {
            motionManager.gyroUpdateInterval = 0.2
            motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {(gyroData: CMGyroData!, error: NSError!) in
                if error != nil {
                    println("x : "+gyroData.rotationRate.x.description)
                    println("y : "+gyroData.rotationRate.y.description)
                    println("z : "+gyroData.rotationRate.z.description)
                }
            })
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged:", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func orientationChanged(notification : NSNotification) {
        println(UIDevice.currentDevice().orientation.rawValue)
    }
}
