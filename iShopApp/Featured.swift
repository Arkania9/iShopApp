//
//  Featured.swift
//  iShopApp
//
//  Created by Kamil Zajac on 13.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit


class Featured {

    var title = ""
    var featuredImage: UIImage
    var price = ""
    var sliderImage: UIImage
    var description: String
    
    init(title: String, featuredImage: UIImage, price: String, sliderImage: UIImage, description: String) {
        self.title = title
        self.featuredImage = featuredImage
        self.price = price
        self.sliderImage = sliderImage
        self.description = description
    }
    
    static func fetchFeatured() -> [Featured] {
        return [
            Featured(title: "RETRO GLASSES", featuredImage: UIImage(named: "bgImage1")!, price: "$133.00", sliderImage: UIImage(named: "First")!, description: "SOMETHING HERE"),
            
            Featured(title: "MODERN DRESS", featuredImage: UIImage(named: "bgImage2")!, price: "$241.50", sliderImage: UIImage(named: "Middle")!, description: "SOMETHING THERE"),
            
            Featured(title: "CUTE SKIRT", featuredImage: UIImage(named: "bgImage3")!, price: "$99.99", sliderImage: UIImage(named: "Last")!, description: "SOMETHING WHERE")

        ]
    }
    
}

