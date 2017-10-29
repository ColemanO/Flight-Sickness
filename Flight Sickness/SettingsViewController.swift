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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(popCurrentViewController))
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem = backButton
        soundtrackSwitch.isOn = Settings.soundtrack()
        soundEffectsSwitch.isOn = Settings.soundEffects()
    }
    @objc func popCurrentViewController(_ animated: Bool) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func soundtrackToggle(_ sender: UISwitch) {
        Settings.setSoundtrack(sender.isOn)
    }
    
    @IBAction func soundEffectToggle(_ sender: UISwitch) {
        Settings.setSoundEffects(sender.isOn)
    }
}
