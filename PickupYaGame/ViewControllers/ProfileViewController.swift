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

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIButton!
    @IBAction func imageButtonTapped(_ sender: Any) {
        requestCameraAccess()
        
    }
    
    // Might need to set delegate here, but dunno
    // Currently
    func goIntoCameraRoll(){
        let imagePickerController = UIImagePickerController()
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
    
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var shoeTF: UITextField!
    @IBOutlet weak var teamTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func alertControllerForCameraAccess() {
        let alertController = UIAlertController(title: "Camera permissions", message: "Are needed for the setting a profile image!", preferredStyle: .alert)
        
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
                    print("allowed camera access")
                } else {
                    self.alertControllerForCameraAccess()
                }
            }
            let photos = PHPhotoLibrary.authorizationStatus()
            if photos == .notDetermined {
                PHPhotoLibrary.requestAuthorization { (status) in
                    if status == .authorized {
                        
                    }
                }
            }
        }
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            goIntoCameraRoll()
        }
        
        func changeProfileDetails() {
            //        UserController.shared.didChangeProfile(name: nameTF.text ?? "Markus Smith", age: ageTF.text ?? "20", favoriteShoe: shoeTF.text ?? "Addidas", favoriteTeam: teamTF.text ?? "Milwaukee Bucks", profileImage: profileImage ?? UIImage(named: "ProfileIcon")) { (success) in
            //            if success == true {
            //            }
            //        }
        }
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         
         */
        
    }
}
