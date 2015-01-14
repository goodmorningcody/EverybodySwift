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
    private var userDefaults : NSUserDefaults?
    
    init() {
        userDefaults = NSUserDefaults(suiteName: "TooDoUserDefaults")
    }
    
    class var sharedInstance : DataController {
        return _instance
    }
    
    func myMessage() -> String? {
        return userDefaults?.objectForKey("key_my_message") as? String
    }
    func setMyMessage(string:String) {
        userDefaults?.setObject(string, forKey: "key_my_message")
    }
    
    private func hasCategory(category:String) -> Bool {
        var currentCategories = self.categories()
        if currentCategories==nil {
            println("저장된 카테고리가 하나도 없습니다.")
            return false
        }
        
        if contains(currentCategories!, category)==false {
            println("\(category)를 찾을 수 없습니다.")
            return false
        }
        
        return true
    }
    func categories() -> [String]? {
        return userDefaults?.objectForKey("key_categories") as? [String]
    }
    func addCategory(category:String) -> Bool {
        if countElements(category)==0 {
            println("입력한 카테고리명이 비어 있습니다.")
            return false
        }
        
        if category=="key_categories" || category=="key_my_message" {
            println("\(category)는 카테고리명으로 사용할 수 없습니다.")
            return false
        }
        
        if hasCategory(category)==true {
            println("\(category)와 동일한 이름의 카테고리가 있습니다.")
            return true
        }
        
        if var currentCategories = self.categories() {
            currentCategories.append(category)
            userDefaults?.setObject(currentCategories, forKey: "key_categories")
        }
        else {
            userDefaults?.setObject([category], forKey: "key_categories")
        }
        
        return true
    }
    func removeTodo(index:Int, category:String) {
        if hasCategory(category) == false {
            return
        }
        
        if var currentTodo = todoInCategory(category) {
            currentTodo.removeAtIndex(index)
            userDefaults?.setObject(currentTodo, forKey: category)
        }
    }
    func addTodo(todo:String, category:String) -> Bool {
        if hasCategory(category)==false && addCategory(category)==false {
            return false
        }
        
        if countElements(todo)==0 {
            return false
        }
        
        var currentTodo = todoInCategory(category)
        if currentTodo==nil {
            currentTodo = [String]()
        }
        
        currentTodo?.append(todo)
        userDefaults?.setObject(currentTodo, forKey: category)
        return true
    }
    func todoInCategory(category:String) -> [String]? {
        var currentCategories = categories()
        if currentCategories==nil {
            return nil
        }
        
        if hasCategory(category)==false {
            return nil
        }
        
        if let totalTodos = userDefaults?.objectForKey(category) as? [String] {
            return totalTodos
        }
        
        return nil
    }
}