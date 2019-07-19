//
//  HomeViewController.swift
//  Find My Face iOS
//
//  Created by Laura Quinn on 2019-07-16.
//  Copyright © 2019 Find My Face. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import CoreImage

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let userID : String = (Auth.auth().currentUser?.uid)!
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
        detect()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var selfieImage: UIImageView!
    
    @IBOutlet var isFace: UILabel!
    
    @IBAction func pickPhoto(_ sender: UIButton) {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary

                present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    @IBAction func uploadToFirebase(_ sender: UIButton) {
        let imageName = NSUUID().uuidString
        let storage = Storage.storage()
        let storageRef = storage.reference().child("Users").child("\(userID)").child("\(imageName).png")
        
        if let uploadData = self.selfieImage.image!.pngData() {
            storageRef.putData(uploadData, metadata: nil, completion: { (_, error) in
                
                if let error = error {
                    print(error)
                    return
                }
                
                storageRef.downloadURL(completion: { (url, err) in
                    if let err = err {
                        print(err)
                        return
                    }
                    
                })
                
            })
        }
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let pickedImage = selectedImageFromPicker {
            selfieImage.contentMode = .scaleAspectFit
            selfieImage.image = pickedImage
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func detect() {
        let myImage = CIImage(image: selfieImage.image!)!
        
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: myImage)
        
        if !faces!.isEmpty {
            isFace.text = "Grin to Begin!"
        } 
    }
    
    
}

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
