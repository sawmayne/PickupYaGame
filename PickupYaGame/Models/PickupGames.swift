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
    let court: String
    let members: [User] = []
    let meetingTimes: String
    let courtImage: UIImage
    
    init(title: String, court: String, courtImage: UIImage, meetingTimes: String) {
        self.title = title
        self.court = court
        self.meetingTimes = meetingTimes
        self.courtImage = courtImage
    }
}
