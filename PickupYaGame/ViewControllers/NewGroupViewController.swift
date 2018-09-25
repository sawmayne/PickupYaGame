//
//  NewGroupViewController.swift
//  PickupYaGame
//
//  Created by Sam on 9/18/18.
//  Copyright © 2018 SamWayne. All rights reserved.
//

import UIKit

class NewGroupViewController: UIViewController {

    @IBOutlet weak var courtImage: UIImageView!
    @IBOutlet weak var meetingDaysTF: UITextField!
    @IBOutlet weak var groupNameTF: UITextField!
    @IBOutlet weak var courtNameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func createGroupTapped(_ sender: Any) {
        guard let name = groupNameTF.text, !name.isEmpty,
            let courtName = courtNameTF.text, !courtName.isEmpty,
            let meetingTimes = meetingDaysTF.text, !meetingTimes.isEmpty
            /*,let courtImage = courtImage */ else { return }
        PickupGamesController.shared.createNewGroup(name: name, court: courtName, courtImage: UIImage(named: "ProfileIconSelected")!, meetingTimes: meetingTimes)
    }
}
