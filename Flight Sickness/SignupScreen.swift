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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func btnSaveUser(_ sender: Any) {
        if (usernameSignupLabel.text?.isEmpty == false && passwordSignupLabel.text?.isEmpty == false) {
            let ref = Database.database().reference()
            ref.child("users").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                if snapshot.hasChild(self.usernameSignupLabel.text!){
                    print("Username is already taken!")
                }else{
                    let user = User(username: self.usernameSignupLabel.text!, password: self.passwordSignupLabel.text!)
                    DataStore.shared.addUser(user: user)
                    print("Added User!")
                    if let navController = self.navigationController {
                        navController.popViewController(animated: true)
                    }
                }
            })
        }
        print("Empty Fields")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 'First Responder' is the same as 'input focus'.
        // We are removing input focus from the text field.
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    //
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

