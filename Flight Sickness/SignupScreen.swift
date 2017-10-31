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

class SignupScreen: UIViewController {
    
    @IBOutlet weak var usernameSignupLabel: UITextField!
    @IBOutlet weak var passwordSignupLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

