//
//  Cart.swift
//  Flight Sickness
//
//  Created by Coleman Oei on 11/15/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import SpriteKit
import GameplayKit

class Cart: SKSpriteNode {
    
    var animation: [SKTexture] = [SKTexture]()
    
    required init() {
        let cartTexture = SKTexture(imageNamed: "Cart")
        super.init(texture: cartTexture, color: UIColor.clear, size: cartTexture.size())
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Cart"), alphaThreshold: 0, size: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = BitMask.gameStopper
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = BitMask.player
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.friction = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.velocity = CGVector(dx: 0, dy: -200)
        self.xScale = 2
        self.yScale = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
