//
//  Check.swift
//  iShopApp
//
//  Created by Kamil Zajac on 20.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

struct Check {
    
    private var _title: String!
    private var _price: Double!
    private var _size: String!
    
    var title: String {
        return _title
    }
    var price: Double {
        return _price
    }
    var size: String {
        return _size
    }
    
    init() {}
    
    init(checkData: Dictionary<String, AnyObject>) {
        guard let itemTitle = checkData["title"] as? String,
        let itemPrice = checkData["price"] as? Double,
        let itemSize = checkData["size"] as? String else {
            return
        }
        self._title = itemTitle
        self._price = itemPrice
        self._size = itemSize
    }
    
}
