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
    @IBOutlet var imageSwitch : UISwitch?
    @IBOutlet var numberCountLabel : UILabel?
    @IBOutlet var countStepper : UIStepper?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for option : ImageModeOption in ImageModeOption.values {
            imageOptionSegmentedControl?.setTitle(option.name(), forSegmentAtIndex:option.rawValue)
        }
        
        if let control=imageSwitch? {
            backgroundImageView?.hidden = !control.on
        }
        
        if let stepper=countStepper? {
            numberCountLabel?.text = Int(stepper.value).description+"개"
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func valueChangedStepper(sender:UIStepper) {
        numberCountLabel?.text = Int(sender.value).description+"개"
    }
    @IBAction func touchedSwitch(sender:UISwitch) {
        backgroundImageView?.hidden = !sender.on
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
    
    func generateLotto()->[Int] {
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
        return results
    }
    @IBAction func touchedGenerateLotto(sender:UIButton) {
        if let stepper = countStepper? {
            var lottoNumberSet : [[Int]] = [[Int]]()
            for index in 0...Int(stepper.value) {
                lottoNumberSet.append(generateLotto())
            }
            UIAlertView(title: "Lotto", message: lottoNumberSet.description, delegate: nil, cancelButtonTitle: "확인").show()
        }
    }
}
