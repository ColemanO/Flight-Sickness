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
    //func createAnimation(atlasName: String) -> [SKTexture]
}

extension Sprite{
//    func createAnimation(atlasName: String) -> [SKTexture]{
//        var spriteAnimation = [SKTexture]()
//        let spriteAtlas = SKTextureAtlas(named: "\(atlasName)")
//        for index in 1...spriteAtlas.textureNames.count{
//            let imgName = String(format: "\(atlasName)%01d", index)
//            spriteAnimation += [spriteAtlas.textureNamed(imgName)]
//        }
//        return spriteAnimation
//    }
    
    func getNode() -> SKSpriteNode{
        return spriteNode
    }
}
