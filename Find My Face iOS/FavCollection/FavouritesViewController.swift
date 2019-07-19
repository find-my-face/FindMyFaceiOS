//
//  FavouritesViewController.swift
//  Find My Face iOS
//
//  Created by Laura Quinn on 2019-07-16.
//  Copyright © 2019 Find My Face. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController, UICollectionViewDataSource {

    var images = [UIImage]()
    
    var favFlowLayout: FavFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadImages()
        favFlowLayout = FavFlowLayout()
        favCollection.collectionViewLayout = favFlowLayout
    }
    
    func loadImages() {
        images.append(UIImage(named: "Shaq")!)
        images.append(UIImage(named: "Shaq2")!)
        images.append(UIImage(named: "Shaq3")!)
        images.append(UIImage(named: "Shaq4")!)
        
        self.favCollection.reloadData()
    }
    
    
    @IBOutlet var favCollection: UICollectionView!
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavsCell", for: indexPath) as! FavCell
        
        // Configure the cell
//        let image = images[indexPath.row]
//        cell.imageView.image = image
        
        return cell
    }
}
