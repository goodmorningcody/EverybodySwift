//
//  SeasonPageViewController.swift
//  UIKitSample
//
//  Created by Cody on 2015. 1. 2..
//  Copyright (c) 2015년 tiekle. All rights reserved.
//

import UIKit

class SeasonPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var imageNameArray = NSArray(array:["season_01", "season_02", "season_03", "season_04"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        if let viewController = viewControllerWithIndex(0) {
            self.setViewControllers([viewController], direction: UIPageViewControllerNavigationDirection.Forward, animated:true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func viewControllerWithIndex(index:Int) -> SeasonViewController? {
        if index<0 || index==imageNameArray.count {
            return nil
        }
        
        if let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("SeasonViewControllerIdentifier") as? SeasonViewController {
            viewController.imageName = imageNameArray[index] as? String
            return viewController
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if let currentViewImageName = (viewController as? SeasonViewController)?.imageName {
            var currentIndex = imageNameArray.indexOfObject(currentViewImageName)
            if !(currentIndex == NSNotFound || currentIndex == 0 ){
                return viewControllerWithIndex(--currentIndex)
            }
        }
        
        return nil
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let currentViewImageName = (viewController as? SeasonViewController)?.imageName {
            var currentIndex = imageNameArray.indexOfObject(currentViewImageName)
            if !(currentIndex == NSNotFound || currentIndex==(self.imageNameArray.count-1)) {
                return viewControllerWithIndex(++currentIndex)
            }
        }
        return nil
    }

}
