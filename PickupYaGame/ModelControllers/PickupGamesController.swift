//
//  PickupGamesController.swift
//  PickupYaGame
//
//  Created by Sam on 9/13/18.
//  Copyright © 2018 SamWayne. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class PickupGamesController {
    
    static let shared = PickupGamesController()
    
    var rootRef = FirebaseManager.shared.rootRef
    let groupRef = FirebaseManager.shared.rootRef.child("Groups")
    
    // Believe this could be used for both creation and editing 
    func createNewGroup(name: String, court: String, courtImage: UIImage, meetingTimes: String)->() {
        // Might have to serialize the image, since firebase has images as a URL/String
        guard let imageAsData = courtImage.jpegData(compressionQuality: 0.5) else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        FirebaseManager.shared.storageRef.child(uid+name).putData(imageAsData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("There was an error uploading image to storage \(error.localizedDescription)")
            }
            
            FirebaseManager.shared.storageRef.child(uid+name).downloadURL(completion: { (url, error) in
                if let error = error {
                    print("Error getting image url back: \(error.localizedDescription)")
                }
                guard let imageUrlAsString = url?.absoluteString else { return }
                
                let uniqueRef = self.groupRef.childByAutoId()
                let groupNameRef = uniqueRef.child("Group Name")
                let groupCourtRef = uniqueRef.child("Group Court")
                let meetingRef = uniqueRef.child("Meeting Times")
                let courtImageRef = uniqueRef.child("Court Image")
                
                self.groupRef.observe(.value) { (DataSnapshot) in
                    groupNameRef.setValue(name)
                    groupCourtRef.setValue(court)
                    courtImageRef.setValue(imageUrlAsString)
                    meetingRef.setValue(meetingTimes)
                }
            })
        }
    }
}
