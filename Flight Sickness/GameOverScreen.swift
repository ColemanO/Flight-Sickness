//
//  GameOverScreen.swift
//  Flight Sickness
//
//  Created by Roshan Dongre on 10/29/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import SpriteKit

class GameOverScreen: SKScene {

    var restartButtonNode:SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        restartButtonNode = self.childNode(withName: "restartButton") as! SKSpriteNode
        //get the pictures for those things
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "restartButton" {
                /*let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)*/
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let restart = SKScene(fileNamed: "GameScene") as! GameScene
                self.view?.presentScene(restart, transition: transition)
            }
        }
    }
    
}
