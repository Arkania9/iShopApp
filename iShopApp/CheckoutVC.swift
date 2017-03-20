//
//  CheckoutVC.swift
//  iShopApp
//
//  Created by Kamil Zajac on 20.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

class CheckoutVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCell") as? CheckoutCell {
            return cell
        }
        return UITableViewCell()
    }

}
