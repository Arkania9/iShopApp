//
//  WomenItemsCell.swift
//  iShopApp
//
//  Created by Kamil Zajac on 15.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit
import FirebaseStorage

class WomenItemsCell: UITableViewCell {
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!

    var item: Item!

    func configureCell(item: Item, img: UIImage? = nil) {
        self.item = item
        if img != nil {
            self.itemImg.image = img
        } else {
            let convertImageURL = NSURL(string: item.imageURL)
            URLSession.shared.dataTask(with: convertImageURL! as URL, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    print(error)
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    self.itemImg.image = image
                    WomenVC.imageCache.setObject(image!, forKey: item.imageURL as NSString)
                })
                
            }).resume()
        }
        self.itemTitle.text = item.title
        self.itemPrice.text = "$\(item.price)"
    }
}
