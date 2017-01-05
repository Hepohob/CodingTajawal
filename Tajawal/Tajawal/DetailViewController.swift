//
//  DetailViewController.swift
//  Tajawal
//
//  Created by Aleksei Neronov on 28.12.16.
//  Copyright © 2016 Aleksei Neronov. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var mapView: MKMapView!
    
    var hotel: Hotel? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        updateUI()
        updateMap()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(imageTapped(img:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)

    }

    func imageTapped(img: AnyObject) {
        if imageView?.image != nil {
            performSegue(withIdentifier: "ShowImageDetailed", sender: nil)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let image = imageView?.image {
            if let ivController = segue.destination as? ImageViewController {
                ivController.image = image
            }
        }
    }

    private func updateUI() {
        hotelName?.text = hotel?.summary.hotelName
        address?.text = hotel?.location.address
        if let highRate:Double = hotel?.summary.highRate,
            let lowRate:Double = hotel?.summary.lowRate {
            price?.attributedText = set(highRate: highRate, lowRate: lowRate)
        }
        if let strURL = self.hotel?.image {
            ImageCacheManager.loadImage(strUrl: strURL) {(image, _ ) in
                if let imageTmp = image {
                    self.self.imageView?.image = imageTmp
                    self.indicator?.stopAnimating()
                }
            }
        }
        title = "Details"
    }

    //MARK: UI Helper
    
    private func set(highRate:Double, lowRate:Double) -> NSMutableAttributedString {
        let result = NSMutableAttributedString(
            string: "\(lowRate)",
            attributes: [NSFontAttributeName:UIFont(
                name: "Georgia",
                size: 14.0)!,
                NSStrikethroughStyleAttributeName: NSNumber(value: NSUnderlineStyle.styleSingle.rawValue)])
        
        let appendString = NSMutableAttributedString(
            string: "   \(highRate)",
            attributes: [NSFontAttributeName:UIFont(
                name: "Georgia",
                size: 18.0)!,
                NSForegroundColorAttributeName:UIColor.red])

        result.append(appendString)
        
        return result
    }

    //MARK: MKMap settings
    
    private func updateMap() {
        // set location of Hotel
        if let lat = hotel?.location.latitude,
            let lon = hotel?.location.longitude {
            let initialLocation = CLLocation(latitude: lat, longitude: lon)
            let regionRadius: CLLocationDistance = 300
            func centerMapOnLocation(location: CLLocation) {
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                          regionRadius * 2.0, regionRadius * 2.0)
                mapView.setRegion(coordinateRegion, animated: true)
            }
            centerMapOnLocation(location: initialLocation)
            // show POI on map
            let poi = POI(title: (hotelName?.text)!,
                                  locationName: (address?.text)!,
                                  discipline: "Hotel",
                                  coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            
            mapView.addAnnotation(poi)
        }
    }
}

