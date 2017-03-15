//
//  WomenVC.swift
//  iShopApp
//
//  Created by Kamil Zajac on 15.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import AlamofireImage
import Alamofire

class WomenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        downloadCurrentItemFromFirebase()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WomenItemsCell") as? WomenItemsCell {
            if let img = imageCache.image(withIdentifier: item.imageURL) {
                cell.configureCell(item: item, img: img)
            } else {
                cell.configureCell(item: item)
            }
            return cell
        }
        return WomenItemsCell()
    }
    
    func downloadCurrentItemFromFirebase() {
        DataService.ds.REF_WOMEN_DB.observe(.value, with: { (snapshot) in
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
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWomenDetails" {
            if let destination = segue.destination as? DetailsVC {
                destination.itemKey = items[tableView.indexPathForSelectedRow!.row].itemKey
            }
        }
    }
    
    
    
    
    
}
