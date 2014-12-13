//
//  ViewController.swift
//  UIKitSample
//
//  Created by Cody on 2014. 12. 11..
//  Copyright (c) 2014년 tiekle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     //- (IBACTION)메소드이름:(UIStoryboardSegue *)
    //func ib
    @IBAction func likedThis(segue:UIStoryboardSegue) {
        NSLog("안녕하세요");
    }

}

