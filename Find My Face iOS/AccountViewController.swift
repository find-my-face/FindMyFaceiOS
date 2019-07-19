//
//  AccountViewController.swift
//  Find My Face iOS
//
//  Created by Laura Quinn on 2019-07-16.
//  Copyright © 2019 Find My Face. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountViewController: UIViewController {

    let userID : String = (Auth.auth().currentUser?.uid)!
    
    let userName: String = (Auth.auth().currentUser?.displayName)!
    
    let userEmail: String = (Auth.auth().currentUser?.email)!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.accountName.text = userName
        self.emailName.text = userEmail
    }
    


    @IBOutlet var accountName: UILabel!

    @IBOutlet var emailName: UILabel!
    
    
    func signOut() -> Bool {
      do {
       try Auth.auth().signOut()
         return true
      } catch {
          return false
      }
    }
    
}
