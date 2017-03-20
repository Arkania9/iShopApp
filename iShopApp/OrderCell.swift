//
//  CartCell.swift
//  iShopApp
//
//  Created by Kamil Zajac on 18.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class OrderCell: UITableViewCell {

    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemColor: UILabel!
    
    var order: Order!
    
    func configureCartCell(orderObj: Order, img: UIImage? = nil) {
        self.order = orderObj
        itemTitle.text = orderObj.title
        itemPrice.text = "$\(orderObj.price)"
        itemColor.text = "COLOR: \(orderObj.color)"
        if img != nil {
            self.itemImg.image = img
        } else {
            let imageURL = URL(string: orderObj.imageURL)
            Alamofire.request(imageURL!).responseImage(completionHandler: { (response) in
                guard let image = response.result.value else {
                    return
                }
                DispatchQueue.main.async(execute: {
                    self.itemImg.image = image
                    imageCache.add(image, withIdentifier: orderObj.imageURL)
                })
            })
        }
    }

}
