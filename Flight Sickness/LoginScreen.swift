//
//  LoginScreen.swift
//  Flight Sickness
//
//  Created by Roshan Dongre on 10/31/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import UIKit

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
       /* ref.child("users").equalTo(usernameLabel.text).once(passwordLabel.text,snapshot => {
            const userData = snapshot.val();
            if (userData){
                console.log("exists!");
            }
            }); */
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
