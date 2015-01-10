//
//  ProximityViewController.swift
//  SensorsDemo
//
//  Created by Cody on 2015. 1. 5..
//  Copyright (c) 2015년 tiekle. All rights reserved.
//

import UIKit

class ProximityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.currentDevice().proximityMonitoringEnabled = true
        if UIDevice.currentDevice().proximityMonitoringEnabled==false {
            println("근접센서를 사용할 수 없습니다.")
        }
        else {
            NSNotificationCenter.defaultCenter().addObserver(self, selector:"proximityChanged:", name:UIDeviceProximityStateDidChangeNotification, object: nil)
        }
    }
    func proximityChanged(notification: NSNotification) {
        if UIDevice.currentDevice().proximityState==true {
            println("proximityChanged - 근접센서가 무언가에 의해 가려졌습니다.")
        }
        else {
            println("proximityChanged - 근접센서를 가린 오브젝트가 없습니다.")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
