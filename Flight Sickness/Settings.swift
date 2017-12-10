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
    fileprivate static let usernameKey = "usernameKey"
        fileprivate static let gcKey = "gameCenterKey"
    fileprivate static let hardModeKey = "hardModeKey"
    
    //Sets the username, soundtrack, and sound effects
    class func setUsername(_ username: String) {
        UserDefaults.standard.set(username, forKey: usernameKey)
        UserDefaults.standard.synchronize()
    }
    
    class func setSoundtrack(_ isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: soundtrackKey)
        UserDefaults.standard.synchronize()
    }
    
    class func setSoundEffects(_ isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: soundEffectsKey)
        UserDefaults.standard.synchronize()
    }
    
    class func setGameCenter(_ useGC: Bool){
        UserDefaults.standard.set(useGC, forKey: gcKey)
        UserDefaults.standard.synchronize()
    }
    
    class func setHardMode(_ isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: hardModeKey)
        UserDefaults.standard.synchronize()
        print("??")
    }
    
    class func username() -> String {
        return UserDefaults.standard.string(forKey: usernameKey)!
    }
    class func soundtrack() -> Bool {
        return UserDefaults.standard.bool(forKey: soundtrackKey)
    }
    class func soundEffects() -> Bool {
        return UserDefaults.standard.bool(forKey: soundEffectsKey)
    }
    class func hardMode() -> Bool {
        return UserDefaults.standard.bool(forKey: hardModeKey)
    }
    
    class func gameCenter() -> Bool{
        return UserDefaults.standard.bool(forKey: gcKey)
    }
    
}
