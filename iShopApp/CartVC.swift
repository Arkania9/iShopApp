//
//  CartVC.swift
//  iShopApp
//
//  Created by Kamil Zajac on 18.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for:UIControlEvents.touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as? CartCell {
            return cell
        }
        return UITableViewCell()
    }
}
