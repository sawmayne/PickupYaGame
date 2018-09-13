//
//  User.swift
//  PickupYaGame
//
//  Created by Sam on 9/12/18.
//  Copyright © 2018 SamWayne. All rights reserved.
//

import UIKit

class User {
    let name: String
    let age: String
    let favoriteShoe: String
    let favoriteTeam: String
    let profileImage: UIImage
    
    init(name: String, age: String, favoriteShoe: String, favoriteTeam: String, profileImage: UIImage) {
        self.name = name
        self.age = age
        self.favoriteShoe = favoriteShoe
        self.favoriteTeam = favoriteTeam
        self.profileImage = profileImage
    }
}
