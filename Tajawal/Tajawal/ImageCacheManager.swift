//
//  ImageCacheManager.swift
//  Tajawal
//
//  Created by Aleksei Neronov on 28.12.16.
//  Copyright © 2016 Aleksei Neronov. All rights reserved.
//

import UIKit

// Structure for downloading and caching images 

struct ImageCacheManager {
    
    private static var cache = NSCache<AnyObject, AnyObject>()
    
    static func loadImage(strUrl: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        if (!strUrl.isEmpty) {
            let checkUrl = strUrl
            DispatchQueue.global(qos: .userInitiated).async {
                if let image = self.cache.object(forKey: strUrl as AnyObject) as? UIImage {
                    DispatchQueue.main.async {
                        completionHandler(image, strUrl)
                    }
                    return
                }
                if let url = NSURL(string: strUrl),
                    let data = NSData(contentsOf: url as URL),
                    var image = UIImage(data: data as Data) {
                    if image.size.width < 2 {
                        if checkUrl == strUrl {
                            completionHandler(UIImage(named: "nophoto")!, strUrl)
                        }
                    }
                    self.cache.setObject(image, forKey: strUrl as AnyObject)
                    DispatchQueue.main.async {
                        if checkUrl == strUrl {
                            completionHandler(image, strUrl)
                        }
                    }
                    return
                } else {
                    DispatchQueue.main.async {
                        if checkUrl == strUrl {
                            completionHandler(UIImage(named: "nophoto")!, strUrl)
                        }
                    }
                    return
                }
            }
        }
    }
    
}
