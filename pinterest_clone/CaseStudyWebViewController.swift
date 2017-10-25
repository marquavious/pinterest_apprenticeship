//
//  CaseStudyWebViewController.swift
//  Pinterest
//
//  Created by Marquavious on 10/24/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import UIKit

class CaseStudyWebViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        self.webView.alpha = 0
        
        displayAlert("Pinterest Case Study", message: "Here is an article displaying my thought process in creating this application! Hope you enjoy! I had a lot of fun building this! 📱")
        
        guard let url = URL(string: "https://medium.com/@marquavious/pinterest-clone-a-case-study-1dc28667f42f") else {
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
