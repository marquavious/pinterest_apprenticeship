//
//  ConnectAndCareWebViewController.swift
//  Pinterest
//
//  Created by Marquavious on 10/24/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import UIKit

class ConnectAndCareWebViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.webView.alpha = 0
         webView.delegate = self
        
        displayAlert("Connect & Care Case Study", message: "This article is a review of how I single-handedly build the application Connect & Care. It's a very impactful application and It's in the App store now! Go download it now! 🙏💰")
        
        guard let url = URL(string: "https://medium.com/@marquavious/connect-care-a-case-study-2f99af793252") else {
            return
        }
        
        webView.loadRequest(URLRequest(url: url))
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIView.animate(withDuration: 0.40, animations: {
            self.webView.alpha = 1
        })
    }
}
