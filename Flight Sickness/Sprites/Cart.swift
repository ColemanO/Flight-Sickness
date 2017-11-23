//
//  Cart.swift
//  Flight Sickness
//
//  Created by Coleman Oei on 11/15/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import SpriteKit
import GameplayKit

class Cart: Obstacle {
    required init() {
        let cartTexture = SKTexture(imageNamed: "Cart")
        super.init(texture: cartTexture, color: UIColor.clear, size: cartTexture.size())
        self.physicsBody?.velocity = CGVector(dx: 0, dy: -200)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
