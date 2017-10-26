//
//  SettingsViewController.swift
//  Flight Sickness
//
//  Created by William Lin on 10/25/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBAction func soundtrackToggle(_ sender: UISwitch) {
        Settings.settings.soundtrack = sender.isOn
    }
    
    @IBAction func soundEffectToggle(_ sender: UISwitch) {
        Settings.settings.soundEffects = sender.isOn
    }
}
