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
    
    var ref = FirebaseManager.shared.ref!
    
    func createNewGroup(name: String, court: String, courtImage: UIImage) {
        ref = Database.database().reference()
        self.ref.child("Group")
    }
}
