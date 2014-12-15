//
//  LottoPickerViewController.swift
//  UIKitSample
//
//  Created by Cody on 2014. 12. 16..
//  Copyright (c) 2014년 tiekle. All rights reserved.
//

import UIKit

class LottoPickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchedGenerateLotto(sender:UIButton) {
        var numbers = [Int]()
        for( var i=1; i<=45; ++i ) {
            numbers.append(i)
        }
        
        var results = [Int]()
        for( var i=0; i<6; ++i ) {
            var range = UInt32(numbers.count)
            var randomIndex = Int(arc4random_uniform(range))
            var result = numbers.removeAtIndex(randomIndex)
            results.append(result)
        }

        UIAlertView(title: "Lotto", message: results.description, delegate: nil, cancelButtonTitle: "확인").show()
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
