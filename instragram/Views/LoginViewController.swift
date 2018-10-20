//
//  LoginViewController.swift
//  instragram
//
//  Created by Felipe De La Torre on 10/16/18.
//  Copyright © 2018 Felipe De La Torre. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //function for empty field
    func missingField(){
        
        //display error message
        let alertController = UIAlertController(title: "Error", message: "Missing username or password.", preferredStyle: .alert)
        // add an ok button
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        // add the OK button to the alert controller
        alertController.addAction(OKAction)
        //displays the alert message
        self.present(alertController, animated: true) {
        }
    }
    
    
    //allows the user to login
    func loginUser() {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
                //display error message
                let alertController = UIAlertController(title: "Login Failed!", message: "Incorrect username or password. Please try again.", preferredStyle: .alert)
                // add an ok button
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                }
                // add the OK button to the alert controller
                alertController.addAction(OKAction)
                //displays the alert message
                self.present(alertController, animated: true) {
                }
                
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    // allow users to sign up
    func signUp() {
        //initialize a user object
        let newUser = PFUser()
        
        // set the new users properties:
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        //calls the sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                
                // display error message
                let alertController = UIAlertController(title: "Signup Failed!", message: "Username already taken. Please try a different one.", preferredStyle: .alert)
                // add an ok button
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                }
                // add the OK button to the alert controller
                alertController.addAction(OKAction)
                //displays the alert message
                self.present(alertController, animated: true) {
                }
                
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    
    //sign up action
    @IBAction func onSIgnup(_ sender: Any) {
        
        let testPass = (passwordField.text?.isEmpty)!
        let testUser = (usernameField.text?.isEmpty)!
        if testPass || testUser == true {
            missingField()
        } else {
            signUp()
        }
    }
    // log in action
    @IBAction func onLogin(_ sender: Any) {
        
        let testPass = (passwordField.text?.isEmpty)!
        let testUser = (usernameField.text?.isEmpty)!
        if testPass || testUser == true {
            missingField()
        } else {
            loginUser()
        }
    }
    
}
