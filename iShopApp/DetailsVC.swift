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
    var myItem: ItemDetails!
    var currentPrice: Double!
    var checkCart = false
    let cartRef = DataService.ds.REF_USER_CURRENT.child("cart")
    
    
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
            self.myItem = ItemDetails(itemKey: self.itemKey, snapshotData: snapshotData)
            self.configureItemInfo(item: self.myItem)
            let itemDetailsImages = ItemDetails(imageData: snapshotData)
            self.imageArray += itemDetailsImages.imageArray
        })
    }
    
    func configureItemInfo(item: ItemDetails) {
        itemNameLbl.text = item.title
        priceLbl.text = "$\(item.price)"
    }
    
    func checkItemsDetailsInCart() {
        cartRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.setItemValue()
            } else {
                guard let snapshotData = snapshot.value as? Dictionary<String, AnyObject> else {
                    return
                }
                self.checkItemExistisInCart(snapshotData: snapshotData)
            }
        })
    }
    
    func checkItemExistisInCart(snapshotData: Dictionary<String, AnyObject>) {
        for snap in snapshotData.keys {
            if snap == itemKey && snap != "totalPrice" {
                checkCart = true
                break
            }
        }
        if !checkCart {
            checkCart = false
            setItemValue()
        }
    }
    
    func setItemValue() {
        let itemRefInCart = cartRef.child(itemKey!)
        let itemData: Dictionary<String, AnyObject> = [
            "price":myItem.price as AnyObject,
            "title":myItem.title as AnyObject,
            "image":myItem.imageURL as AnyObject
        ]
        itemRefInCart.setValue(itemData)
        checkAndUpdateTotalPriceInCart(isInCart: checkCart)
    }
    
    func checkAndUpdateTotalPriceInCart(isInCart: Bool) {
        if !isInCart {
            let totalPriceInCart = cartRef.child("totalPrice")
            totalPriceInCart.observeSingleEvent(of: .value, with: { (snapshot) in
                if let _ = snapshot.value as? NSNull {
                    totalPriceInCart.setValue(self.myItem.price)
                } else {
                    let total = snapshot.value as! Double
                    totalPriceInCart.setValue(total + self.myItem.price)
                }
            })
        }
    }
    
    @IBAction func addToCartPressed(_ sender: AnyObject) {
        checkItemsDetailsInCart()
    }
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
