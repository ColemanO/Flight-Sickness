//
//  GameCenter.swift
//  Flight Sickness
//
//  Created by Coleman Oei on 10/27/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import Foundation
import GameKit

class GameCenter{
    class func saveHighscore(number : Int){
        if GKLocalPlayer.localPlayer().isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "FSL")
        
            scoreReporter.value = Int64(number)
        
            let scoreArray : [GKScore] = [scoreReporter]
        
            GKScore.report(scoreArray, withCompletionHandler: nil)
        }
        
    }
    
//    class func authenticatePlayer()->UIViewController?{
//        let localPlayer = GKLocalPlayer.localPlayer()
//        var ret:UIViewController? = nil
//        localPlayer.authenticateHandler = {
//            
//            (view, error) in
//            if view != nil {
//                ret = view!
//                print("setting view!!!!!")
//                //self.present(view!, animated: true, completion: nil)
//                
//            }
//            else {
//                print(GKLocalPlayer.localPlayer().isAuthenticated)
//                
//            }
//            
//        }
//        if(ret == nil){print("NIIIIIIIL")}
//        return ret
//    }
}
