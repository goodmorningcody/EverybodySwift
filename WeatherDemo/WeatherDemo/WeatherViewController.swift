//
//  WeatherViewController.swift
//  WeatherDemo
//
//  Created by Cody on 2015. 1. 11..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var currentLocation : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateCurrentLocation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined && locationManager.respondsToSelector(Selector("requestWhenInUseAuthorization")) == true {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        currentLocation = locations[locations.count - 1] as? CLLocation
        manager.stopUpdatingLocation()
        getWehaterButton?.enabled = true
    }
    
    @IBOutlet var getWehaterButton : UIButton?
    @IBOutlet var gettedWehaterTextView : UITextView?
    
    @IBAction func touchedGetWeatherButton(sender: UIButton) {
        let urlString = "http://api.openweathermap.org/data/2.5/weather?lat=\(currentLocation!.coordinate.latitude)&lon=\(currentLocation!.coordinate.longitude)"
        
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.currentQueue(), completionHandler: { (response, data, error) -> Void in
                let jsonObject : AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: nil)
                if let weather = jsonObject?["weather"] as? NSArray {
                    if weather.count>0 {
                        self.gettedWehaterTextView?.text = weather[0]["description"] as? NSString
                        return
                    }
                }
                self.gettedWehaterTextView?.text = "날씨 정보를 가져오지 못했습니다."
            })
        }
        
    }
}
