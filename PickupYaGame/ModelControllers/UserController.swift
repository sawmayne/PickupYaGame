//
//  UserController.swift
//  PickupYaGame
//
//  Created by Sam on 9/13/18.
//  Copyright © 2018 SamWayne. All rights reserved.
//
import UIKit
import FirebaseAuth
import FirebaseDatabase
import AVFoundation
import Photos

class UserController {
    static let shared = UserController()
    // TODO: CoreLocation
    let uid = Auth.auth().currentUser?.uid

    func didChangeProfile(name: String, age: String, favoriteShoe: String, favoriteTeam: String, profileImage: UIImage, completion: @escaping ((Bool)-> Void)) {
        guard let imageAsData = profileImage.jpegData(compressionQuality: 0.5) else { completion(false) ; return }
        
        Auth.auth().currentUser?.createProfileChangeRequest().commitChanges(completion: { (error) in
            if let error = error {
                print("There was an error changing profile data in firebase \(error.localizedDescription)")
            }
            let usersRef = FirebaseManager.shared.rootRef.child("Users").child(self.uid!)
            let values = ["name" : name,
                          "age" : age,
                          "favoriteShoe" : favoriteShoe,
                          "favoriteTeam" : favoriteTeam,
                          "profileImage" : imageAsData] as [String : Any]
            usersRef.updateChildValues(values, withCompletionBlock: { (error, reference) in
                if let error = error {
                    print("There was an error updating the values for the user \(error.localizedDescription)")
                    return
                }
            })
        })
    }
}
