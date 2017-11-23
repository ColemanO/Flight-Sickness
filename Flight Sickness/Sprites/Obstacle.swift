//
//  Obstacle.swift
//  Flight Sickness
//
//  Created by William Lin on 11/22/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import Foundation
import SpriteKit

// TODO: clean up animation handling
class Obstacle: SKSpriteNode {
    // whether this obstacle should always start from top of screen
    var startFromTop: Bool = true
    
    init(texture: SKTexture, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.physicsBody = SKPhysicsBody(
            texture: texture, alphaThreshold: 0, size: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = BitMask.gameStopper
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = BitMask.player
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.friction = 0
        self.physicsBody?.linearDamping = 0
        self.xScale = 2
        self.yScale = 2
    }
    required init() {
        super.init(texture: nil, color: UIColor(), size: CGSize())
        fatalError("subclasses should call init(texture:color:size) instead")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // subclasses should override this function if they want to
    // perform any animations after being generated
    func animate() {
    }
    
    // remove self from parent and returns true if we can't be seen anymore
    //FIXME
    /*
    @discardableResult func cleanUp(bottomScreen: CGFloat) -> Bool {
        if (self.position.y < bottomScreen) {
            self.removeFromParent()
            return true
        }
        return false
    }
 */
}
