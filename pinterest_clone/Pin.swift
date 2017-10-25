//
//  Pin.swift
//  Pinterest
//
//  Created by Marquavious on 10/23/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import UIKit
import SwiftyJSON

class Pin {
    
    var description: String
    var imageLink: String
    var backgroundColor: UIColor
    var height: CGFloat
    var width: CGFloat
    var postUrl: String
    
    init?(_ json: JSON) {
        guard
        let imageLink = json["images"]["orig"]["url"].string,
        let heightOfImage = json["images"]["orig"]["height"].float,
        let widthOfImage = json["images"]["orig"]["width"].float,
        let postUrl = json["link"].string,
        var backgroundColorHex = json["dominant_color"].string
        else {
            return nil
        }

        backgroundColorHex.remove(at: backgroundColorHex.startIndex)
        
        self.description = json["description"].stringValue
        self.imageLink = imageLink
        self.postUrl = postUrl
        self.backgroundColor = UIColor(hex:String(backgroundColorHex))
        self.height = CGFloat(heightOfImage)
        self.width = CGFloat(widthOfImage)
        self.width = 867
    }
    
    func heightForComment(_ font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: description).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)
    }
    
}
