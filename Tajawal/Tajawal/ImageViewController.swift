//
//  ImageViewController.swift
//  Tajawal
//
//  Created by Aleksei Neronov on 29.12.16.
//  Copyright © 2016 Aleksei Neronov. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var detailedImage: UIImageView!
    
    var image:UIImage? {
        didSet {
            updateUI()
        }
    }
    
    // prepare controller for showing
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(imageTapped(img:)))
        detailedImage.isUserInteractionEnabled = true
        detailedImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func imageTapped(img: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

    // UI settings
    private func updateUI() {
        detailedImage?.image = image
        detailedImage?.sizeToFit()
    }
}
