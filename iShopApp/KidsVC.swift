//
//  KidsVC.swift
//  iShopApp
//
//  Created by Kamil Zajac on 21.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit
import FirebaseDatabase

class KidsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for:UIControlEvents.touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        downloadCurrentItemFromFirebase()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "KidsItemsCell") as? KidsItemsCell {
            if let img = imageCache.image(withIdentifier: item.imageURL) {
                cell.configureCell(item: item, img: img)
            } else {
                cell.configureCell(item: item)
            }
            return cell
        }
        return KidsItemsCell()
    }
    
    func downloadCurrentItemFromFirebase() {
        DataService.ds.REF_KIDS_DB.observe(.value, with: { (snapshot) in
            self.items = []
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if let itemDict = snap.value as? Dictionary<String, AnyObject> {
                        let itemKey = snap.key
                        let item = Item(itemKey: itemKey, itemData: itemDict)
                        self.items.append(item)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailsFromKids" {
            if let destination = segue.destination as? DetailsVC {
                destination.itemKey = items[tableView.indexPathForSelectedRow!.row].itemKey
                destination.currentRefDb = DataService.ds.REF_KIDS_DB
                destination.viewColor = UIColor(red: 229/255, green: 92/255, blue: 92/255, alpha: 1.0)
                destination.titleNavigation = "KIDS"
            }
        }
    }

}
