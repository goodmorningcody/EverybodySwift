//
//  WebViewTestViewController.swift
//  UIKitSample
//
//  Created by Cody on 2014. 12. 27..
//  Copyright (c) 2014년 tiekle. All rights reserved.
//

import UIKit

class WebViewTestViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webView : UIWebView?
    
    func webViewDidFinishLoad(webView: UIWebView) {
        var alert = UIAlertView(title: "UIAlertView", message: "로딩이 완료되었습니다.", delegate: nil, cancelButtonTitle: "확인")
        alert.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchedOpenSafari(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string:"http://apple.com")!)
    }
    
    @IBAction func touchedTestUIWebView(sender: UIButton) {
        let request = NSURLRequest(URL:NSURL(string:"http://apple.com")!)
        webView?.loadRequest(request)
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
