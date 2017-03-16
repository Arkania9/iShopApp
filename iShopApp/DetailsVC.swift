//
//  DetailsVC.swift
//  iShopApp
//
//  Created by Kamil Zajac on 15.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit
import FirebaseDatabase
import AlamofireImage
import Alamofire

class DetailsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var itemNameLbl: UILabel!
    var itemKey: String!
    var imageArray = [String]()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        downloadItemDetailsFromFirebase()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageString = imageArray[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath) as? DetailsCell {
            if let img = imageCache.image(withIdentifier: imageString) {
                cell.configureImage(imageString: imageString, img: img)
            } else {
                cell.configureImage(imageString: imageString)
            }
            return cell
        }
       return UICollectionViewCell()
    }
    
    func downloadItemDetailsFromFirebase() {
        DataService.ds.REF_WOMEN_DB.child("\(itemKey!)").observe(.value, with: { (snapshot) in
            guard let snapshotData = snapshot.value as? Dictionary<String, AnyObject> else {
                return
            }
            let itemDetails = ItemDetails(snapshotData: snapshotData)
            self.configureItemInfo(item: itemDetails)
            let itemDetailsImages = ItemDetails(imageData: snapshotData)
            self.imageArray += itemDetailsImages.imageArray
        })
    }
    
    func configureItemInfo(item: ItemDetails) {
        itemNameLbl.text = item.title
        priceLbl.text = "$\(item.price)"
    }
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
