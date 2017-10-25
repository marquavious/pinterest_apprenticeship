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
    var dominantBackgroundColor: UIColor
    var height: CGFloat
    var width: CGFloat
    
    init?(_ json: JSON) {
        
        guard // If the posts dont have these minimun requirements, return nil
        let imageLink = json["images"]["orig"]["url"].string,
        let heightOfImage = json["images"]["orig"]["height"].float,
        let widthOfImage = json["images"]["orig"]["width"].float,
        var backgroundColorHex = json["dominant_color"].string
        else { return nil }

        // Edit hex string
        backgroundColorHex.remove(at: backgroundColorHex.startIndex)
        
        self.description = json["description"].stringValue // Some post dont have a description
        self.imageLink = imageLink
        self.dominantBackgroundColor = UIColor(hex:String(backgroundColorHex))
        self.height = CGFloat(heightOfImage)
        self.width = CGFloat(widthOfImage)
    }
    
    func heightForComment(_ font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: description).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)
    }
    
}
