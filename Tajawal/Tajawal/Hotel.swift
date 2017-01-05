//
//  Hotel.swift
//  Tajawal
//
//  Created by Aleksei Neronov on 28.12.16.
//  Copyright © 2016 Aleksei Neronov. All rights reserved.
//

import Foundation


// a simple container class which just holds the data

open class Hotel : NSObject
{
    open let hotelId: String
    open let image: String
    open let location: Location
    open let summary: Summary
    
    // MARK: - Internal Implementation
    
    init?(data: NSDictionary?)
    {
        guard
            let hotelId = data?.value(forKeyPath: HotelKey.HotelId) as? Int,
            let imageStr = data?.value(forKeyPath: HotelKey.Image) as? Array<Dictionary<String, Any>>,
            let address = data?.value(forKeyPath: HotelKey.Location.Address) as? String,
            let longitude = data?.value(forKeyPath: HotelKey.Location.Longitude) as? Double,
            let latitude = data?.value(forKeyPath: HotelKey.Location.Latitude) as? Double,
            let hotelName = data?.value(forKeyPath: HotelKey.Summary.HotelName) as? String,
            let highRate = data?.value(forKeyPath: HotelKey.Summary.HighRate) as? Double,
            let lowRate = data?.value(forKeyPath: HotelKey.Summary.LowRate) as? Double
            else {
                return nil
        }
        self.hotelId = "\(hotelId)"
        var urlTemp:String? = nil
        if imageStr.count > 0 {
            if let dicURL = imageStr[0] as? Dictionary<String, String>,
                let strURL = dicURL["url"] {
                urlTemp = strURL
            }
        }
        self.image = urlTemp ?? ""
        self.location = Location.init(address: address, latitude: latitude, longitude: longitude)
        self.summary = Summary.init(hotelName: hotelName, highRate: highRate, lowRate: lowRate)
    }
    
    struct HotelKey {
        static let HotelId = "hotelId"
        static let Image  = "image"
        struct Location {
            static let Address = "location.address"
            static let Latitude = "location.latitude"
            static let Longitude = "location.longitude"
        }
        struct Summary {
            static let HighRate = "summary.highRate"
            static let HotelName = "summary.hotelName"
            static let LowRate = "summary.lowRate"
        }
    }
    
}

open class Location : NSObject
{
    open let address: String
    open let latitude: Double
    open let longitude: Double
    
    init(address: String, latitude: Double, longitude: Double)
    {
        self.address = address
        self.longitude = longitude
        self.latitude = latitude
    }
}

open class Summary : NSObject
{
    open let highRate: Double
    open let hotelName: String
    open let lowRate: Double
    
    init(hotelName: String, highRate: Double, lowRate: Double)
    {
        self.hotelName = hotelName
        self.highRate = highRate
        self.lowRate = lowRate
    }
}
