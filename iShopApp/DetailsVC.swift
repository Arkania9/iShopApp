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
import AMPopTip

class DetailsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var popTipView: UIView!
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var green: UIButton!
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var pink: UIButton!
    @IBOutlet weak var black: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var itemKey: String!
    var imageArray = [String]()
    var myItem: ItemDetails!
    var currentPrice: Double!
    var checkCart = false
    let cartRef = DataService.ds.REF_USER_CURRENT.child("cart")
    let popTip = AMPopTip()
    var color = "black"
    var size = "XS"
    let sizes = ["XS","S","M","L","XL","XXL"]
    
        override func viewDidLoad() {
        super.viewDidLoad()
            collectionView.delegate = self
            collectionView.dataSource = self
            self.popTip.shouldDismissOnTap = true
            self.popTip.edgeMargin = 5
            self.popTip.offset = 2
            self.popTip.edgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
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
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sizes[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sizes.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        size = sizes[row]
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
            "image":myItem.imageURL as AnyObject,
            "color":color as AnyObject,
            "size":size as AnyObject
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
    
    func changeColorAlpha(maxAlpha: UIButton, color1: UIButton, color2: UIButton,color3: UIButton, color4: UIButton) {
        maxAlpha.alpha = 1.0
        color1.alpha = 0.4
        color2.alpha = 0.4
        color3.alpha = 0.4
        color4.alpha = 0.4
    }
    
    func switchColor(_ sender: AnyObject) {
        switch sender.tag {
        case 0:
            self.changeColorAlpha(maxAlpha: red, color1: green, color2: blue, color3: pink, color4: black)
            break
        case 1:
            self.changeColorAlpha(maxAlpha: green, color1: red, color2: blue, color3: pink, color4: black)
            break
        case 2:
            self.changeColorAlpha(maxAlpha: blue, color1: red, color2: green, color3: pink, color4: black)
            break
        case 3:
            self.changeColorAlpha(maxAlpha: pink, color1: red, color2: green, color3: blue, color4: black)
            break
        case 4:
            self.changeColorAlpha(maxAlpha: black, color1: red, color2: green, color3: blue, color4: pink)
            break
        default: break
        }
    }
    
    @IBAction func colorPressed(_ sender: AnyObject) {
        let colorsArray = ["Red","Green","Blue","Pink","Black"]
        color = colorsArray[sender.tag]
        switchColor(sender)
    }

    @IBAction func addToCartPressed(_ sender: AnyObject) {
        checkItemsDetailsInCart()
    }
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    

}






