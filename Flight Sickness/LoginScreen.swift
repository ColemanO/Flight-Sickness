//
//  LoginScreen.swift
//  Flight Sickness
//
//  Created by Roshan Dongre on 10/31/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class LoginScreen: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    var alertController:UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.delegate = self
        passwordLabel.delegate = self
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        DataStore.shared.loadUsers()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        
        if (usernameLabel.text?.isEmpty == false && passwordLabel.text?.isEmpty == false) {
            let ref = Database.database().reference()
            ref.child("users").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                if snapshot.hasChild(self.usernameLabel.text!){
                    
                    //TODO: Add Firebase Authentication for a scalable application
                    if (DataStore.shared.matchingPassword(username: self.usernameLabel.text!, password: self.passwordLabel.text!))
                    {
                        // save username
                        Settings.setUsername(self.usernameLabel.text!)
                        print("Valid username and password!")
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! UINavigationController
                        self.present(newViewController, animated: true, completion: nil)
                    }
                    else {
                        self.presentAlert(title: "Invalid Login", msg: "Invalid username or password")
                        print("Invalid password")
                    }
                    
                }else{
                    self.presentAlert(title: "Invalid Login", msg: "Invalid username or password")
                    print("Invalid username")
                }
            })
        }
        print("Fields are empty")
    }
    
    func presentAlert(title: String, msg: String){
        self.alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
        }
        self.alertController!.addAction(OKAction)
        
        self.present(self.alertController!, animated: true, completion:nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 'First Responder' is the same as 'input focus'.
        // We are removing input focus from the text field.
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

