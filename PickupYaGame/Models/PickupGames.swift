//
//  PickupGames.swift
//  PickupYaGame
//
//  Created by Sam on 9/12/18.
//  Copyright © 2018 SamWayne. All rights reserved.
//

import UIKit

class PickupGames {
    let title: String
    let description: String
    let court: String
    let members: [User] = []
    let meetingDays: String
    let courtImage: UIImage
    
    init(title: String, court: String, description: String, meetingDays: String, courtImage: UIImage) {
        self.title = title
        self.court = court
        self.description = description
        self.meetingDays = meetingDays
        self.courtImage = courtImage
    }
}
