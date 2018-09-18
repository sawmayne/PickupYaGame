//
//  EmailViewController.swift
//  PickupYaGame
//
//  Created by Sam on 9/18/18.
//  Copyright © 2018 SamWayne. All rights reserved.
//

import UIKit
import FirebaseAuth

class EmailViewController: UIViewController {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var SegmentControl: UISegmentedControl!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var isSignIn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signInButtonTapped(_ sender: Any) {
        // validation on email and password :(
        guard let email = emailTF.text, !email.isEmpty,
            let password = passwordTF.text, !password.isEmpty else { return }
        if isSignIn {
            // sign in
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    print("there was an error signing in \(error.localizedDescription)")
                }
                if let user = user {
                    // segue into homescreen
                } else {
                    print("Could not find valid user")
                    // present alertcontroller
                }
            }
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    print("There was an error creating new user with firebase \(error.localizedDescription)")
                }
            }
        }
    }
    
    @IBAction func didChangeSegment(_ sender: Any) {
        isSignIn = !isSignIn
        if isSignIn {
            signInButton.titleLabel?.text = "Sign in"
        } else {
            signInButton.titleLabel?.text = "Sign up"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
