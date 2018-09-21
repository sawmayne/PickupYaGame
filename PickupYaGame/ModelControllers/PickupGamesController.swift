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


class PickupGamesController {
    
    static let shared = PickupGamesController()
    
    var rootRef = FirebaseManager.shared.rootRef
    let groupRef = FirebaseManager.shared.rootRef.child("Groups")
    
    // Believe this could be used for both creation and editing 
    func createNewGroup(name: String, court: String, courtImage: UIImage, meetingTimes: String) {
        // Might have to serialize the image, since firebase has images as a URL/String
        
        let imageAsImage = UIImage(data: courtImage.jpegData(compressionQuality: 0.5)!)
        let imageAsData =  imageAsImage?.jpegData(compressionQuality: 1.0)
        
        let uniqueRef = self.groupRef.childByAutoId()
        let groupNameRef = uniqueRef.child("GroupName")
        let groupCourtRef = uniqueRef.child("GroupCourt")
        let courtImageRef = uniqueRef.child("CourtImage")
        
        groupRef.observe(.value) { (DataSnapshot) in
            
            groupNameRef.setValue(name)
            groupCourtRef.setValue(court)
            courtImageRef.setValue(imageAsData)
            
        }
    }
}
