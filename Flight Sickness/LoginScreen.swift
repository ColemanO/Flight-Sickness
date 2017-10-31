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

class LoginScreen: UIViewController {
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
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
                        print("Valid username and password!")
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
                        self.present(newViewController, animated: true, completion: nil)
                    }
                    else {
                        print("Invalid password")
                    }
                    
                }else{
                    print("Invalid username")
                }
            })
        }
        print("Fields are empty")
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

