//
//  SettingsViewController.swift
//  Flight Sickness
//
//  Created by William Lin on 10/25/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var soundtrackSwitch: UISwitch!
    @IBOutlet weak var soundEffectsSwitch: UISwitch!
    @IBOutlet weak var hardModeSwitch: UISwitch!
    @IBOutlet weak var settingsView: UIView!
    
    //var cloudGen = CloudGenerator()
    
    //Hides the back button with a new image that is the back button
    override func viewDidLoad() {
        super.viewDidLoad()
        //cloudGen.genClouds(view: view)
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(popCurrentViewController))
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem = backButton
        soundtrackSwitch.isOn = Settings.soundtrack()
        soundEffectsSwitch.isOn = Settings.soundEffects()
        hardModeSwitch.isOn = Settings.hardMode()
        let containerView:UIView = UIView(frame:self.settingsView.frame)
        //self.bckTableView = UITableView(frame: containerView.bounds, style: .plain)
        containerView.backgroundColor = UIColor.clear
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 2
        
        self.settingsView.layer.cornerRadius = 10
        self.settingsView.layer.masksToBounds = true
        self.view.addSubview(containerView)
        containerView.addSubview(self.settingsView)
    }
    
    //Pops off the current view controller
    @objc func popCurrentViewController(_ animated: Bool) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //Toggles the soundtrack
    @IBAction func soundtrackToggle(_ sender: UISwitch) {
        Settings.setSoundtrack(sender.isOn)
    }
    
    //Toggles the sound effects
    @IBAction func soundEffectToggle(_ sender: UISwitch) {
        Settings.setSoundEffects(sender.isOn)
    }
    
    @IBAction func hardModeToggle(_ sender: UISwitch) {
        Settings.setHardMode(sender.isOn)
    }
    
    //Logout Button
    @IBAction func logoutPressed(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "passKey")
        UserDefaults.standard.removeObject(forKey: "usKey")
        UserDefaults.standard.removeObject(forKey: "usernameKey")
    }
}
