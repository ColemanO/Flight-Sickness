//
//  Bag.swift
//  Flight Sickness
//
//  Created by William Lin on 11/16/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import SpriteKit
import GameplayKit

class Bag: Obstacle {
    required init() {
        let bagTexture = SKTexture(imageNamed: "Bag")
        super.init(texture: bagTexture, color: UIColor.clear, size: bagTexture.size())
        // disable bag's collision before it lands
        self.physicsBody?.contactTestBitMask = 0
        self.startFromTop = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func animate() {
        // TODO clean this up
        let scaleUp = SKAction.scale(to: 6, duration: 0.0)
        let fade = SKAction.fadeIn(withDuration: 1.3)
        let scaleDown = SKAction.scale(to: 2, duration: 1.3)
        let group = SKAction.group([scaleDown, fade])
        let enableContact = SKAction.run {
            // enable collision after it lands
            self.physicsBody?.contactTestBitMask = BitMask.player
        }
        self.run(.sequence([
            .fadeOut(withDuration: 0),
            scaleUp,
            group,
            enableContact
            ]))
    }
    
    override func cleanUp() {
        // reset the test bit
        self.physicsBody?.contactTestBitMask = 0
    }
}
