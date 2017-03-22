//
//  MainVC.swift
//  iShopApp
//
//  Created by Kamil Zajac on 13.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuButton: UIButton!
    var featured = Featured.fetchFeatured()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        startTimer()
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for:UIControlEvents.touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featured.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionCell {
            cell.featured = featured[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func scrollToNextCell(){
        let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        let contentOffset = collectionView.contentOffset
        if collectionView.contentSize.width <= collectionView.contentOffset.x + cellSize.width {
            collectionView.scrollRectToVisible(CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
        } else {
            collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
        }
    }

    func startTimer() {
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector:
            #selector(MainVC.scrollToNextCell), userInfo: nil, repeats: true)
    }

}
