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
        soundtrackSwitch.isOn = Settings.soundtrack()
        soundEffectsSwitch.isOn = Settings.soundEffects()
    }
    
    @IBAction func soundtrackToggle(_ sender: UISwitch) {
        Settings.setSoundtrack(sender.isOn)
    }
    
    @IBAction func soundEffectToggle(_ sender: UISwitch) {
        Settings.setSoundEffects(sender.isOn)
    }
}
