//
//  Sprite.swift
//  Flight Sickness
//
//  Created by Coleman Oei on 10/25/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol Sprite{
    var animation: [SKTexture] {get set}
    var spriteNode: SKSpriteNode {get set}
    func getNode() -> SKSpriteNode
}

extension Sprite{
    func getNode() -> SKSpriteNode{
        return spriteNode
    }
}
