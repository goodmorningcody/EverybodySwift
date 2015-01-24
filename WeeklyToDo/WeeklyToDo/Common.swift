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
var _hightlightColor = UIColor(red:245.0/255.0, green: 108.0/255.0, blue: 114.0/255.0, alpha: 1)

var _hightlightFont = UIFont(name: "Helvetica Bold", size: 22.0)

class Color {
    class func getHightlightColor() -> UIColor {
        return _hightlightColor
    }
    class func getNavigationBackgroundColor() -> UIColor {
        return _navigationBackgroundColor
    }
}

class Font {
    class func getHightlightFont() -> UIFont {
        return _hightlightFont!
    }
}