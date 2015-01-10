//
//  GPSViewController.swift
//  SensorsDemo
//
//  Created by Cody on 2015. 1. 5..
//  Copyright (c) 2015년 tiekle. All rights reserved.
//

import UIKit
import CoreLocation

class GPSViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined && locationManager.respondsToSelector(Selector("requestWhenInUseAuthorization")) == true {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchedUpdateOrStopButton(sender: UIButton) {
        if sender.selected {
            locationManager.stopUpdatingLocation()
            locationManager.stopUpdatingHeading()
        }
        else {
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
        
        sender.selected = !sender.selected
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        println(newHeading.x)
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        var location:CLLocation = locations[locations.count - 1] as CLLocation
        println(location.coordinate.longitude)
        println(location.coordinate.latitude)
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
