//
//  ProfileViewController.swift
//  PickupYaGame
//
//  Created by Sam on 9/18/18.
//  Copyright © 2018 SamWayne. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import FirebaseAuth

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: IBOutlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var shoeTF: UITextField!
    @IBOutlet weak var teamTF: UITextField!
    @IBOutlet weak var profileImage: UIButton!
    
    // MARK: -Constants
    let imagePickerController = UIImagePickerController()
    var imageAsData = Data()
    
    // MARK: IBActions
    @IBAction func imageButtonTapped(_ sender: Any) {
        requestCameraAccess()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        changeProfileDetails()
    }
    
    func goIntoCameraRoll(){
        let imagePickerController = self.imagePickerController
        let actionSheet = UIAlertController(title: "Where From?", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_: UIAlertAction) in
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        readProfileData()
        clipImage()
    }
    
    func clipImage() {
        profileImage.layer.masksToBounds = false
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.height/2
    }
    // REFACTOR TO BE IN CONTROLLER
    func loadImageFrom(imageURL: String, completion: @escaping ((UIImage?)->Void)) {
        let downloadedData = FirebaseManager.shared.storageRef.child("Images")
        downloadedData.getData(maxSize: 5 * 1024 * 1024) { (data, error) in
            if let error = error {
                print("Error loading image from Storage: \(error.localizedDescription)")
                completion(nil)
            }
            guard let imageData = data,
                let image = UIImage(data: imageData) else { completion(nil) ; return }
            completion(image)
        }
    }
    
    func readProfileData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        FirebaseManager.shared.rootRef.child("Users").child(uid).observe(.value) { (datasnapshot) in
            let value = datasnapshot.value as? NSDictionary
            
            self.nameTF.text = value?["Name"] as? String ?? ""
            self.ageTF.text = value?["Age"] as? String ?? ""
            self.shoeTF.text = value?["Favorite Shoe"] as? String ?? ""
            self.teamTF.text = value?["Favorite Shoe"] as? String ?? ""
            let imageAsString = value?["Image"] as? String ?? ""
            
            self.loadImageFrom(imageURL: imageAsString, completion: { (image) in
                guard let image = image else { return }
                self.profileImage.setBackgroundImage(image, for: .normal)
            })
        }
    }
    
    func alertControllerForCameraAccess() {
        let alertController = UIAlertController(title: "Camera permissions", message: "Are needed for the setting a profile image!", preferredStyle: .alert)
        
        // buttons for the alert controller
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) in
            let settingsURL = URL(string: UIApplication.openSettingsURLString)!
            UIApplication.shared.open(settingsURL)
        }
        
        alertController.addAction(okAction)
        alertController.addAction(settingsAction)
        alertController.preferredAction = settingsAction
        present(alertController, animated: true, completion: nil)
    }
    
    func requestCameraAccess() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { (success) in
                if success {
                    self.goIntoCameraRoll()
                    print("allowed camera access")
                } else {
                    self.alertControllerForCameraAccess()
                }
            }
            let photos = PHPhotoLibrary.authorizationStatus()
            if photos == .notDetermined {
                PHPhotoLibrary.requestAuthorization { (status) in
                    if status == .authorized {
                        self.goIntoCameraRoll()
                    }
                    if status == .denied {
                        self.alertControllerForCameraAccess()
                    }
                }
            }
        }
        if AVCaptureDevice.authorizationStatus(for: .video) == .denied {
            alertControllerForCameraAccess()
        }
        
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            goIntoCameraRoll()
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.profileImage.setBackgroundImage(image, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func changeProfileDetails() {
        UserController.shared.didChangeProfile(name: nameTF.text ?? "", age: ageTF.text ?? "", favoriteShoe: shoeTF.text ?? "", favoriteTeam: teamTF.text ?? "", profileImage: profileImage.backgroundImage(for: .normal)!) { (success) in
            if success == true {
                print("yay")
            }
        }
    }
}
