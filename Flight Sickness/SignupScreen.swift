//
//  SignupScreen.swift
//  Flight Sickness
//
//  Created by Roshan Dongre on 10/31/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import UIKit

class SignupScreen: UIViewController {

    @IBOutlet weak var usernameSignupLabel: UITextField!
    @IBOutlet weak var passwordSignupLabel: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSaveUser(_ sender: Any) {
        let user = User(username: usernameSignupLabel.text!, password: passwordSignupLabel.text!)
        DataStore.shared.addUser(user: user)
        outputLabel.text = "Person Added!"
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
