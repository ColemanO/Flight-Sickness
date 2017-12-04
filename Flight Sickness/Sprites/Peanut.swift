//
//  Peanut.swift
//  Flight Sickness
//
//  Created by William Lin on 12/3/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import SpriteKit
import GameplayKit

class Peanut: Obstacle {
    required init() {
        let texture = SKTexture(imageNamed: "peanut")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        // disable bag's collision before it lands
        self.physicsBody?.categoryBitMask = BitMask.powerUp
        self.physicsBody?.contactTestBitMask = BitMask.player
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func cleanUp() {
        // reset the test bit
        //self.physicsBody?.contactTestBitMask = BitMask.player
    }
}
