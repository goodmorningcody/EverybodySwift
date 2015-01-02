//
//  SeasonViewController.swift
//  UIKitSample
//
//  Created by Cody on 2015. 1. 2..
//  Copyright (c) 2015년 tiekle. All rights reserved.
//

import UIKit

class SeasonViewController: UIViewController {

    @IBOutlet var backgroundImageView : UIImageView?
    var imageName : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let settedImageName = imageName {
            backgroundImageView?.image = UIImage(named: settedImageName)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }    
}
