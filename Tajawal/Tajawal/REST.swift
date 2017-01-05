//
//  REST.swift
//  Tajawal
//
//  Created by Aleksei Neronov on 28.12.16.
//  Copyright © 2016 Aleksei Neronov. All rights reserved.
//

import Foundation
import Alamofire

// Class containing REST API
class REST: NSObject {
    
    // global array for list of hotels
    
    static var hotels: [Hotel]?
   
    class func getHotels(){
        hotels = []
        Alamofire.request(URLs.base).responseJSON { response in
            if let JSON = response.result.value {
                if let hotelDictionary = JSON as? Dictionary<String, Any> {
                    if let hotelsArray = hotelDictionary["hotel"]  as? [NSDictionary] {
                        for hotelElement in hotelsArray {
                            if let hotel = Hotel.init(data: hotelElement as NSDictionary?) {
                                hotels?.append(hotel)
                            }
                        }
                        NotificationCenter.default.post(name: .hotelsUpdated, object: nil)
                    }
                }
            }
        }
        
    }
}

// Register notification name

extension Notification.Name {
    static let hotelsUpdated = Notification.Name("HotelsUpdated")
}
