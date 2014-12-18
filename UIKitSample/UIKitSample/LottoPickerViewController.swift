//
//  LottoPickerViewController.swift
//  UIKitSample
//
//  Created by Cody on 2014. 12. 16..
//  Copyright (c) 2014년 tiekle. All rights reserved.
//

import UIKit

enum ImageModeOption : Int {
    case ScaleToFill, ScaleAspectFill, ScaleAspectFit
    
    static let values = [ScaleToFill, ScaleAspectFill, ScaleAspectFit]
    
    func name() -> String {
        switch self {
        case ScaleToFill:
            return "Scale to Fill"
        case ScaleAspectFill:
            return "Aspect Fill"
        case ScaleAspectFit:
            return "Aspect Fit"
        }
    }
}

class LottoPickerViewController: UIViewController {
    
    @IBOutlet var backgroundImageView : UIImageView?
    @IBOutlet var imageOptionSegmentedControl : UISegmentedControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for option : ImageModeOption in ImageModeOption.values {
            imageOptionSegmentedControl?.setTitle(option.name(), forSegmentAtIndex:option.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func touchedSegmented(sender:UISegmentedControl) {
        if sender.selectedSegmentIndex==ImageModeOption.ScaleToFill.rawValue {
            backgroundImageView?.contentMode = UIViewContentMode.ScaleToFill
        }
        else if sender.selectedSegmentIndex==ImageModeOption.ScaleAspectFit.rawValue {
            backgroundImageView?.contentMode = UIViewContentMode.ScaleAspectFit
        }
        else if sender.selectedSegmentIndex==ImageModeOption.ScaleAspectFill.rawValue {
            backgroundImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        }
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
}
