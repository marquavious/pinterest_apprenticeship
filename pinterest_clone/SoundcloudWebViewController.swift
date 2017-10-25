//
//  SoundcloudWebViewController.swift
//  Pinterest
//
//  Created by Marquavious on 10/24/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import UIKit

class SoundcloudWebViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.webView.alpha = 0
         webView.delegate = self
        
        displayAlert("Check out my music!", message: "I am a producer on the side. This is where I usually unleash my creativity. Check them out!...Iv'e been told they're fire 🔥👀")

        guard let url = URL(string: "https://soundcloud.com/marquavious-draggon") else {
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
