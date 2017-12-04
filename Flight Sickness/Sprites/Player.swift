//
//  Player.swift
//  Flight Sickness
//
//  Created by Coleman Oei on 10/25/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import SpriteKit
import GameplayKit

class Player: Sprite {
    
    var animation: [SKTexture] = [SKTexture]()
    var spriteNode: SKSpriteNode
    
    required init(node: SKSpriteNode) {
        spriteNode = node
        animation = createAnimation(atlasName: "player")
        playAnimation()
    }
    func jump(isLeft: Bool){
        spriteNode.removeAction(forKey: "running")
        self.spriteNode.texture = SKTexture(image: #imageLiteral(resourceName: "playerjump.png"))
        if isLeft{
            spriteNode.xScale = -spriteNode.xScale
        }
    }
}
