//
//  ViewControllerExtentions.swift
//  Pinterest
//
//  Created by Marquavious on 10/24/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    func displayAlert(_ title: String, message: String){
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok!", style: .default, handler: { (action) in }))
        self.present(alert, animated: true, completion: nil)
    }
}
