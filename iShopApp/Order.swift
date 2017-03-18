//
//  Cart.swift
//  iShopApp
//
//  Created by Kamil Zajac on 18.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import Foundation

struct Order {
    
    private var _imageURL: String!
    private var _price: Double!
    private var _title: String!
    
    var imageURL: String {
        return _imageURL
    }
    var price: Double {
        return _price
    }
    var title: String {
        return _title
    }
    
    init(orderData: Dictionary<String, AnyObject>) {
        guard let itemImage = orderData["image"] as? String,
        let itemPrice = orderData["price"] as? Double,
        let itemTitle = orderData["title"] as? String else {
            return
        }
        self._imageURL = itemImage
        self._price = itemPrice
        self._title = itemTitle
    }
    
    
}
