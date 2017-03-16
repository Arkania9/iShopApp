//
//  DetailsCell.swift
//  iShopApp
//
//  Created by Kamil Zajac on 16.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class DetailsCell: UICollectionViewCell {
    @IBOutlet weak var bgImage: UIImageView!
    var itemDetails: ItemDetails!
    
    func configureImage(imageString: String, img: UIImage? = nil) {
        if img != nil {
            self.bgImage.image = img
        } else {
            let imageURL = URL(string: imageString)
            Alamofire.request(imageURL!).responseImage(completionHandler: { (response) in
                guard let image = response.result.value else {
                    return
                }
                DispatchQueue.main.async(execute: {
                    self.bgImage.image = image
                    imageCache.add(image, withIdentifier: imageString)
                })
            })
        }
    }
    
}
