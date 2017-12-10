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
    
    class func authenticatePlayer(sender: UIViewController){
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = {
            (view, error) in
            if view != nil {
                sender.present(view!, animated: true, completion: nil)
                if(GKLocalPlayer.localPlayer().isAuthenticated){
                    Settings.setGameCenter(true)
                }
            }
            else {
                print(GKLocalPlayer.localPlayer().isAuthenticated)
                if(GKLocalPlayer.localPlayer().isAuthenticated){
                    Settings.setGameCenter(true)
                }
            }
        }
    }
    
    class func saveHighscore(number : Int){
        
        if GKLocalPlayer.localPlayer().isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "FSL")
        
            scoreReporter.value = Int64(number)
        
            let scoreArray : [GKScore] = [scoreReporter]
        
            GKScore.report(scoreArray, withCompletionHandler: nil)
        }
        
    }
}
