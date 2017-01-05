//
//  POI.swift
//  Tajawal
//
//  Created by Aleksei Neronov on 29.12.16.
//  Copyright © 2016 Aleksei Neronov. All rights reserved.
//

import MapKit

class POI: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
