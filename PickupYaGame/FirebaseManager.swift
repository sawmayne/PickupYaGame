//
//  FirebaseManager.swift
//  PickupYaGame
//
//  Created by Sam on 9/18/18.
//  Copyright © 2018 SamWayne. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseManager {
    static let shared = FirebaseManager()
    
     var ref: DatabaseReference!
    
    func setupFirebaseAuthSettings(){
        // dont actually know if this is needed
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "Test")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID("com.SamWayne.PickupYaGame")
    }
}
