//
//  CheckoutCell.swift
//  iShopApp
//
//  Created by Kamil Zajac on 20.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

class CheckoutCell: UITableViewCell {

    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemQnt: UILabel!
    var checkObj: Check!
    
    func configureCheckout(checkObj: Check) {
        self.checkObj = checkObj
        itemTitle.text = checkObj.title
        itemPrice.text = "$\(checkObj.price)"
    }

}
