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
    private var _totalPrice: Double!
    
    var title: String {
        return _title
    }
    var price: Double {
        return _price
    }
    var totalPrice: Double {
        return _totalPrice
    }
    
    init() {}
    
    init(checkData: Dictionary<String, AnyObject>) {
        guard let itemTitle = checkData["title"] as? String,
        let itemPrice = checkData["price"] as? Double else {
            return
        }
        self._title = itemTitle
        self._price = itemPrice
    }
    
}
