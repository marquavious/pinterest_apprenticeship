//
//  PinterestLayout.swift
//  Pinterest
//
//  Created by Marquavious on 10/23/17.
//  CCopyright © 2017 Marquavious Draggon. All rights reserved.
//

import UIKit


class RoundedCornersView: UIView {
    
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}
