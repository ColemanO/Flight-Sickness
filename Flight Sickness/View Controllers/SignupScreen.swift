//
//  SignupScreen.swift
//  Flight Sickness
//
//  Created by Roshan Dongre on 10/31/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class SignupScreen: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameSignupLabel: UITextField!
    @IBOutlet weak var passwordSignupLabel: UITextField!
    var alertController:UIAlertController? = nil
    //Valid characters you can use for login and password info
    let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
    //var cloudGen = CloudGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cloudGen.genClouds(view: view)
        usernameSignupLabel.delegate = self
        passwordSignupLabel.delegate = self
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(popCurrentViewController))
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem = backButton
        // Do any additional setup after loading the view.
    }
    
    @objc func popCurrentViewController(_ animated: Bool) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Saves the username and password when you create an account, checks for string validity
    @IBAction func btnSaveUser(_ sender: Any) {
        if (usernameSignupLabel.text?.isEmpty == false && passwordSignupLabel.text?.isEmpty == false && usernameSignupLabel.text?.rangeOfCharacter(from: characterset.inverted) == nil &&
            passwordSignupLabel.text?.rangeOfCharacter(from: characterset.inverted) == nil) {
            let ref = Database.database().reference()
            ref.child("people").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                if snapshot.hasChild(self.usernameSignupLabel.text!){
                    print("Username is already taken!")
                    self.presentAlert(title: "Username Taken", msg: "That username is already taken")
                }else{
                    let person = Person(username: self.usernameSignupLabel.text!, password: self.passwordSignupLabel.text!, score: 0)
                    DataStore.shared.addUser(person: person)
                    print("Added User!")
                    if let navController = self.navigationController {
                        navController.popViewController(animated: true)
                    }
                }
            })
        }
        else {
            self.presentAlert(title: "Invalid Input", msg: "Can't leave empty or use special characters")
        }
    }
    
    //Alert method for presenting alerts
    func presentAlert(title: String, msg: String){
        self.alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            print("Ok Button Pressed 1");
        }
        self.alertController!.addAction(OKAction)
        
        self.present(self.alertController!, animated: true, completion:nil)
    }
    
    //Allows you to hit return to exit the text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 'First Responder' is the same as 'input focus'.
        // We are removing input focus from the text field.
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

