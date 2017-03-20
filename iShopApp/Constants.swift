//
//  Constants.swift
//  iShopApp
//
//  Created by Kamil Zajac on 15.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import Foundation
import AlamofireImage
import Alamofire

let imageCache = AutoPurgingImageCache(
    memoryCapacity: 100_000_000,
    preferredMemoryUsageAfterPurge: 60_000_000
)
extension Array {
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
