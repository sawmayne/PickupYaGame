//
//  AuthViewController.swift
//  PickupYaGame
//
//  Created by Sam on 9/18/18.
//  Copyright © 2018 SamWayne. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AuthViewController: UIViewController {
    
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
        
        FirebaseManager.shared.setupFirebaseAuthSettings()
        
        // TODO: validation on email (existing email) and password (requirements) :(
        
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
                    print("There was an error creating new user \(error.localizedDescription)")
                }
                if let user = user {
                    // segue into application
                    navigationController?.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
                    func addUserToDatabase() {
                        // i believe this to be setting child nodes for user, which are identifiable by their id, will set properties later in usercontroller
                        var ref = FirebaseManager.shared.ref
                        ref = Database.database().reference()
                        ref?.child("users/\(user.user.uid)/username").setValue(user.user.uid)
                    }
                } else {
                    print("Could not find valid user with firebase")
                }
            }
        }
    }
    
    @IBAction func didChangeSegment(_ sender: Any) {
        isSignIn = !isSignIn
        if isSignIn {
            signInButton.setTitle("Sign in", for: .normal)
        } else {
            signInButton.setTitle("Sign up", for: .normal)
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
