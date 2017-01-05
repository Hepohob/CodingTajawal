//
//  HotelCollectionViewCell.swift
//  Tajawal
//
//  Created by Aleksei Neronov on 28.12.16.
//  Copyright © 2016 Aleksei Neronov. All rights reserved.
//

import UIKit

class HotelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagePlaceholder: UIImageView!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var hotel: Hotel? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        hotelName.attributedText = nil
        imagePlaceholder.image = nil
        
        if let hotel = self.hotel {
            hotelName?.text = hotel.summary.hotelName
        }
        
        if let strURL = self.hotel?.image {
            ImageCacheManager.loadImage(strUrl: strURL) {(image, _ ) in
                if let imageTmp = image {
                    self.self.imagePlaceholder?.image = imageTmp
                    self.indicator.stopAnimating()
                }
            }
        }
        
    }

}
