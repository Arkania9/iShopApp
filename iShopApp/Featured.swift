//
//  Featured.swift
//  iShopApp
//
//  Created by Kamil Zajac on 13.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

class Featured {
    var description = ""
    var featuredImage: UIImage
    var price = ""
    var sliderImage: UIImage
    
    init(description: String, featuredImage: UIImage, price: String, sliderImage: UIImage) {
        self.description = description
        self.featuredImage = featuredImage
        self.price = price
        self.sliderImage = sliderImage
    }
    
    static func fetchFeatured() -> [Featured] {
        return [
            Featured(description: "RETRO GLASSES", featuredImage: UIImage(named: "bgImage")!, price: "$133.00", sliderImage: UIImage(named: "First")!),
            Featured(description: "MODERN DRESS", featuredImage: UIImage(named: "bgImage2")!, price: "$241.50", sliderImage: UIImage(named: "Middle")!),
            Featured(description: "CUTE SKIRT", featuredImage: UIImage(named: "bgImage3")!, price: "$99.99", sliderImage: UIImage(named: "Last")!)
        ]
    }
    
}

