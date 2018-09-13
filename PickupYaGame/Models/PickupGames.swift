//
//  PickupGames.swift
//  PickupYaGame
//
//  Created by Sam on 9/12/18.
//  Copyright © 2018 SamWayne. All rights reserved.
//

import Foundation

class PickupGames {
    let title: String
    let court: String
    let members: [User] = []
    
    init(title: String, court: String) {
        self.title = title
        self.court = court
    }
}
