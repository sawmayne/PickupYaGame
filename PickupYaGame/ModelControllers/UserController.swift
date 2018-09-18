//
//  UserController.swift
//  PickupYaGame
//
//  Created by Sam on 9/13/18.
//  Copyright © 2018 SamWayne. All rights reserved.
//

import Foundation
import FirebaseAuth
class UserController {
    func setupFirebaseAuth(){
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "Test")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID("com.SamWayne.PickupYaGame")
    }

    func signUp(email: String) {
        
    }
    //    func signup(
    
    // func signin(email: String, password: String) {
}
