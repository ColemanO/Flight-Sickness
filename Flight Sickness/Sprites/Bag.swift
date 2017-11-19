//
//  Bag.swift
//  Flight Sickness
//
//  Created by William Lin on 11/16/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import SpriteKit
import GameplayKit

class Bag: SKSpriteNode {
    
    var animation: [SKTexture] = [SKTexture]()
    
    required init() {
        super.init(texture: SKTexture(imageNamed: "Settings"), color: UIColor.blue, size: CGSize(width: 200, height: 200))
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Settings"), alphaThreshold: 0, size: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = BitMask.gameStopper
        self.physicsBody?.collisionBitMask = 0
        //self.physicsBody?.contactTestBitMask = BitMask.player
        self.physicsBody?.contactTestBitMask = 0
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.friction = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.velocity = CGVector(dx: 0, dy: -200)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func animateBags(_ bags: [Bag]) {
        for bag in bags {
            bag.animate()
        }
    }
    
    func animate() {
        // this should be able to be done better
        let scaleUp = SKAction.scale(to: 2, duration: 0.0)
        let fade = SKAction.fadeIn(withDuration: 1.0)
        let scaleDown = SKAction.scale(to: 1, duration: 1.0)
        let group = SKAction.group([scaleDown, fade])
        self.run(.sequence([
            .fadeOut(withDuration: 0),
            scaleUp,
            group
            ]))
        
        // enable collision after it lands
        self.physicsBody?.contactTestBitMask = BitMask.player
    }
}
