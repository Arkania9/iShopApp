//
//  DetailsVC.swift
//  iShopApp
//
//  Created by Kamil Zajac on 15.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DetailsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    var itemKey: String!
    var imageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        downloadCurrentItem()
    }

    func downloadCurrentItem() {
        DataService.ds.REF_WOMEN_DB.child("\(itemKey!)").observe(.value, with: { (snapshot) in
            guard let snapshotData = snapshot.value as? Dictionary<String, AnyObject> ,
            let images = snapshotData["images"] as? Dictionary<String, AnyObject>,
            let image1 = images["image1"] as? String,
            let image2 = images["image2"] as? String else {
                return
            }
        })
    }
    
    func convertUrlToImage(image1: String, image2: String) {
        let image1URL = URL(string: image1)
        let image2URL = URL(string: image2)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath) as? DetailsCell{
            return cell
        }
        return UICollectionViewCell()
    }
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
