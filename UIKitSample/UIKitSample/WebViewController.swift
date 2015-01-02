//
//  WebServiceViewController.swift
//  UIKitSample
//
//  Created by Cody on 2015. 1. 1..
//  Copyright (c) 2015년 tiekle. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet var webView : UIWebView?
    
    private var urlString : String = "http://daum.net"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func request() {
        if let url = NSURL(string:urlString) {
            let request = NSURLRequest(URL:url)
            webView?.loadRequest(request)
        }
    }
    
    func setUrl(url:String) {
        urlString = url
        if isViewLoaded() {
            request()
        }
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
