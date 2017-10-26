//
//  Setting.swift
//  Flight Sickness
//
//  Created by William Lin on 10/25/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import Foundation

class Settings: NSObject {
    fileprivate static let soundtrackKey = "soundtrack"
    fileprivate static let soundEffectsKey = "soundEffects"
    
    class func setSoundtrack(_ isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: soundtrackKey)
        UserDefaults.standard.synchronize()
    }
    class func setSoundEffects(_ isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: soundEffectsKey)
        UserDefaults.standard.synchronize()
    }
    
    class func soundtrack() -> Bool {
        return UserDefaults.standard.bool(forKey: soundtrackKey)
    }
    class func soundEffects() -> Bool {
        return UserDefaults.standard.bool(forKey: soundEffectsKey)
    }
}
