//
//  ImageCollectionCell.swift
//  iShopApp
//
//  Created by Kamil Zajac on 13.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var sliderImg: UIImageView!

    var featured: Featured? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        productLbl.text = featured?.title
        priceLbl.text = featured?.price
        bgImage.image = featured?.featuredImage
        sliderImg.image = featured?.sliderImage
    }
    
}
