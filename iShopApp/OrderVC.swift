//
//  CartVC.swift
//  iShopApp
//
//  Created by Kamil Zajac on 18.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

class OrderVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLbl: UILabel!

    let cartRef = DataService.ds.REF_USER_CURRENT.child("cart")
    var orderArray = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        downloadEachItemFromCart()
        
        
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for:UIControlEvents.touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderObj = orderArray[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? OrderCell {
            if let img = imageCache.image(withIdentifier: orderObj.imageURL) {
                cell.configureCartCell(orderObj: orderObj, img: img)
            } else {
                cell.configureCartCell(orderObj: orderObj)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func downloadEachItemFromCart() {
        cartRef.observe(.value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
            } else {
                if let cartData = snapshot.value as? Dictionary<String, AnyObject> {
                    for cart in cartData {
                        if cart.key == "totalPrice" {
                            self.totalPriceLbl.text = "$\(cart.value as! Double)"
                            continue
                        }
                        let orderObj = Order(orderData: cart.value as! Dictionary<String, AnyObject>)
                        self.orderArray.append(orderObj)
                    }
                }
                self.tableView.reloadData()
            }
        })
    }
    
    func removeItemsFromCart() {
        cartRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.orderArray = []
            } else {
                self.orderArray = []
                self.cartRef.removeValue()
            }
            self.tableView.reloadData()
            self.totalPriceLbl.text = "$0.0"
        })
    }
    
    @IBAction func removeOrderPressed(_ sender: AnyObject) {
        removeItemsFromCart()
    }
    
    
}







