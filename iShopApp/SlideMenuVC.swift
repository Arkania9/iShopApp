//
//  SlideMenuVC.swift
//  iShopApp
//
//  Created by Kamil Zajac on 13.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit
import Firebase

class SlideMenuVC: UIViewController {
    @IBOutlet weak var numberLbl: UILabel!
    let cartRef = DataService.ds.REF_USER_CURRENT.child("cart")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNumberOfOrders()
    }
    
    func updateNumberOfOrders() {
        cartRef.observe(.value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.numberLbl.text = "(0)"
            } else {
                guard let cartDict = snapshot.value as? Dictionary<String, AnyObject> else {
                    return
                }
                self.numberLbl.text = "(\(cartDict.count-1))"
            }
        })
    }

}
