//
//  MatchPhotosViewController.swift
//  Find My Face iOS
//
//  Created by Laura Quinn on 2019-07-18.
//  Copyright © 2019 Find My Face. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth


class MatchPhotosViewController: UIViewController, UICollectionViewDataSource {
    
    let userID : String = (Auth.auth().currentUser?.uid)!
    let storage = Storage.storage()
    //    let storageRef = storage.reference().child("Users").child("\(userID)").child("match")

    @IBOutlet var imageCollection: UICollectionView!
    var images = [UIImage]()
    
    var customFlowLayout: CustomFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadImages()
        customFlowLayout = CustomFlowLayout()
        imageCollection.collectionViewLayout = customFlowLayout
    }
    
    func loadImages() {
        images.append(UIImage(named: "Shaq")!)
        images.append(UIImage(named: "Shaq2")!)
        images.append(UIImage(named: "Shaq3")!)
        images.append(UIImage(named: "Shaq4")!)
        images.append(UIImage(named: "Shaq5")!)
    
        self.imageCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FireCell", for: indexPath) as! FirebasePhotoCell
        
        // Configure the cell
        let image = images[indexPath.row]
        cell.imageView.image = image
        
        return cell
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
