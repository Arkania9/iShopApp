//
//  CheckoutVC.swift
//  iShopApp
//
//  Created by Kamil Zajac on 20.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit
import Firebase

class CheckoutVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    let cartRef = DataService.ds.REF_USER_CURRENT.child("cart")
    var checkArray = [Check]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromUserOrder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let checkObj = checkArray[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCell") as? CheckoutCell {
            cell.configureCheckout(checkObj: checkObj)
            return cell
        }
        return CheckoutCell()
    }
    
    func getDataFromUserOrder() {
        cartRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                print("NO ITEMS IN ORDER")
            } else {
                guard let checkData = snapshot.value as? Dictionary<String, AnyObject> else {
                    return
                }
                self.changeDataToUserOrder(checkData: checkData)
            }
        })
    }
    
    func changeDataToUserOrder(checkData: Dictionary<String, AnyObject>) {
        for check in checkData {
            if check.key == "totalPrice" {
                self.totalPriceLbl.text = "TOTAL: $\(check.value as! Double)"
                continue
            }
            let checkObj = Check(checkData: check.value as! Dictionary<String, AnyObject>)
            self.checkArray.append(checkObj)
        }
        self.tableView.reloadData()
    }

    @IBAction func confirmOrderPressed(_ sender: AnyObject) {
        
    }
    
    
}
