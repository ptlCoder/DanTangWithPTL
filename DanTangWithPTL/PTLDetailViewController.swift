//
//  PTLDetailViewController.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/9/12.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit
import SVProgressHUD

class PTLDetailViewController: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
    
    var detailURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: 加载webView
        myWebView.loadRequest(NSURLRequest(URL: NSURL(string: detailURL)!))
    }
}


extension PTLDetailViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView){
    
        SVProgressHUD.showWithStatus("正在加载...")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }

    func webViewDidFinishLoad(webView: UIWebView){
        
        SVProgressHUD.dismiss()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?){
        SVProgressHUD.dismiss()
        SVProgressHUD.showErrorWithStatus("加载失败")
    }
}
