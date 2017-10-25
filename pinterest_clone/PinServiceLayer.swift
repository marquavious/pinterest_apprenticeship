//
//  PinServiceLayer.swift
//  Pinterest
//
//  Created by Marquavious on 10/23/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PinServiceLayer {
    
    typealias GrabPinsCompletion = (Error?,[Pin]) -> ()
    
    static func grabPins(completion: @escaping GrabPinsCompletion) {
        
        var tempArray = [Pin]()
        
        if let path = Bundle.main.path(forResource: "pins_formatted", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonResult = JSON(data)
                for i in jsonResult.arrayValue {
                    if let pin = Pin(i) {
                        tempArray.append(pin)
                    }
                }
                completion(nil, tempArray)
            } catch {
                completion(NSError(), [])
                return
            }
        }
    }
}
