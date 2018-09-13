//
//  Chat.swift
//  PickupYaGame
//
//  Created by Sam on 9/12/18.
//  Copyright © 2018 SamWayne. All rights reserved.
//

import Foundation
class Chat {
    let user: User
    let message: String
    init(message: String, user: User) {
        self.message = message
        self.user = user
    }
}
