//
//  WomenItemsCell.swift
//  iShopApp
//
//  Created by Kamil Zajac on 15.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit
import FirebaseStorage
import AlamofireImage
import Alamofire
class WomenItemsCell: UITableViewCell {
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    var imageUrlString: String?
    var item: Item!

    func configureCell(item: Item, img: UIImage? = nil) {
        self.item = item
        imageUrlString = item.imageURL
        if img != nil {
            self.itemImg.image = img
        } else {
            let imageURL = URL(string: item.imageURL)
            Alamofire.request(imageURL!).responseImage(completionHandler: { (response) in
                guard let image = response.result.value else {
                    return
                }
                DispatchQueue.main.async(execute: {
                    if self.imageUrlString == item.imageURL {
                        self.itemImg.image = image
                    }
                    imageCache.add(image, withIdentifier: item.imageURL)
                })
            })
        }
        self.itemTitle.text = item.title
        self.itemPrice.text = "$\(item.price)"
    }
}
