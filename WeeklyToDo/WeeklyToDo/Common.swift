//
//  Common.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 24..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import Foundation
import UIKit

var _navigationBackgroundColor = UIColor(red: 231.0/255.0, green: 227.0/255.0, blue: 224.0/255.0, alpha: 1)
var _pointColor = UIColor(red:245.0/255.0, green: 108.0/255.0, blue: 114.0/255.0, alpha: 1)
var _hightlightColor = UIColor(red:96.0/255.0, green: 84.0/255.0, blue: 72.0/255.0, alpha: 1)

var _taskTextColor = UIColor(red: 95.0/255.0, green: 84.0/255.0, blue: 72.0/255.0, alpha: 1)
var _taskDoneTextColor = UIColor(red: 200.0/255.0, green: 197.0/255.0, blue: 195.0/255.0, alpha: 1)

class Color {
    class func getPointColor() -> UIColor {
        return _pointColor
    }
    class func getHighlightColor() -> UIColor {
        return _hightlightColor
    }
    class func getNavigationBackgroundColor() -> UIColor {
        return _navigationBackgroundColor
    }
    //class func getTaskTextColor() ->
}

var _hightlightFont = UIFont(name: "Helvetica Bold", size: 22.0)

class Font {
    class func getHightlightFont() -> UIFont {
        return _hightlightFont!
    }
}