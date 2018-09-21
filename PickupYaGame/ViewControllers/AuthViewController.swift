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
    
    // MARK: - IBOutlets
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var SegmentControl: UISegmentedControl!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    // this checks the segmented controller and sets up for login/sign up
    
    var isSignIn: Bool = true
    
    var uuid: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    func createUser() {
        guard let email = emailTF.text, !email.isEmpty,
            let password = passwordTF.text, !password.isEmpty else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("There was an error creating new user \(error.localizedDescription)")
                return
            } else {
                guard let user = user else { return }
                let rootRef = FirebaseManager.shared.rootRef.child("Users").child(user.user.uid)
                rootRef.updateChildValues(["Name" : "",
                                           "Image" : "",
                                           "Favorite shoe" : "",
                                           "Favorite team" : "",
                                           "Age" : ""] as [String: Any], withCompletionBlock: { (error, _) in
                                            if let error = error {
                                                print("Error updating child values: \(error.localizedDescription)")
                                            }
                                            let sb = UIStoryboard(name: "Main", bundle: nil)
                                            let tabBarController = sb.instantiateViewController(withIdentifier: "TabBarController")
                                            self.present(tabBarController, animated: true, completion: nil)
                })
            }
        }
    }
    func signIn() {
        guard let email = emailTF.text, !email.isEmpty,
            let password = passwordTF.text, !password.isEmpty else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print("there was an error signing in \(error.localizedDescription)")
            }
            //                guard let uid = Auth.auth().currentUser?.uid else { return }
            // fetch user with id
            if authResult != nil {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let tabBarController = sb.instantiateViewController(withIdentifier: "TabBarController")
                self.present(tabBarController, animated: true, completion: nil)
                // segue into homescreen
                // TODO: Present AuthViewController modally above the tab bar controller, might need a custom TabBarController file for it, not sure.
                // self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
            } else {
                
                print("Could not find valid user")
                // present alertcontroller
            }
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        if isSignIn {
            signIn()
        } else {
            createUser()
        }
    }
    // fetches the user ID
    func fetchUUID() {
        Database.database().reference().child("Users").observeSingleEvent(of: .value) { (DataSnapshot) in
            guard let uuid = DataSnapshot.value as? Int else { return }
            self.uuid = uuid
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
}

extension AuthViewController: UITextFieldDelegate {
    
    func setDelegates() {
        emailTF.delegate = self
        passwordTF.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        emailTF.returnKeyType = .next
        passwordTF.returnKeyType = .done
        
        if textField == emailTF {
            passwordTF.becomeFirstResponder()
        }
        if textField == passwordTF {
            textField.resignFirstResponder()
        }
        return true
    }
}
