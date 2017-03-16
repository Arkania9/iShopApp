//
//  ItemDetails.swift
//  iShopApp
//
//  Created by Kamil Zajac on 15.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import Foundation

class ItemDetails {
    
    private var _title: String!
    private var _price: Double!
    private var _imageURL: String!
    
    var title: String {
        return _title
    }
    var price: Double {
        return _price
    }
    var imageURL: String {
        return _imageURL
    }
    var imageArray = [String]()

    init(title: String, price: Double, imageURL: String) {
        self._title = title
        self._price = price
        self._imageURL = imageURL
    }
    
    init() {}
    
    init(imageData: Dictionary<String, AnyObject>) {
        guard let images = imageData["images"] as? Dictionary<String, AnyObject>,
        let image1 = images["image1"] as? String,
        let image2 = images["image2"] as? String,
        let image3 = images["image3"] as? String else {
             return
        }
        imageArray += [image1,image2,image3]
    }
    
    init(snapshotData: Dictionary<String, AnyObject>) {
        guard let title = snapshotData["title"] as? String,
        let price = snapshotData["price"] as? Double else {
            return
        }
        self._title = title
        self._price = price
    }
    
    
}
