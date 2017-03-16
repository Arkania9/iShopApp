//
//  Item.swift
//  iShopApp
//
//  Created by Kamil Zajac on 15.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import Foundation

class Item {
    
    private var _title: String!
    private var _imageURL: String!
    private var _price: Double!
    private var _itemKey: String!
    
    var title: String {
        return _title
    }
    var imageURL: String {
        return _imageURL
    }
    var price: Double {
        return _price
    }
    var itemKey: String {
        return _itemKey
    }
    
    init(title: String, imageURL: String, price: Double) {
        self._title = title
        self._imageURL = imageURL
        self._price = price
    }
    
    init(itemKey: String, itemData: Dictionary<String, AnyObject>) {
        self._itemKey = itemKey
        
        guard let title = itemData["title"] as? String,
        let images = itemData["images"] as? Dictionary<String, AnyObject>,
        let imageURL = images["image1"] as? String,
        let price = itemData["price"] as? Double else {
            return
        }
        self._imageURL = imageURL
        self._price = price
        self._title = title
    }
    
}
