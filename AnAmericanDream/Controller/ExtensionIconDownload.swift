//
//  ExtensionIconDownload.swift
//  AnAmericanDream
//
//  Created by Hugues Fils Caparos on 27/04/2020.
//  Copyright © 2020 Hugues Fils Caparos. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImageFromURL(url: String) {
        self.image = nil
        guard let URL = URL(string: url) else {
            return
        }

        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL) {
                if let image = UIImage(data: data) {
                    let imageToCache = image
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)

                    DispatchQueue.main.async {
                        self?.image = imageToCache
                    }
                }
            }
        }
    }
}
