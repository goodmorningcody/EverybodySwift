//
//  DataController.swift
//  TooDo
//
//  Created by Cody on 2015. 1. 13..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import Foundation

private let _instance = DataController()

class DataController {
    class var sharedInstance : DataController {
        return _instance
    }
    
    public func myMessage() -> String? {
        return NSUserDefaults.standardUserDefaults().objectForKey("key_my_message") as? String
    }
    public func setMyMessage(string:String) {
        NSUserDefaults.standardUserDefaults().setObject(string, forKey: "key_my_message")
    }
}