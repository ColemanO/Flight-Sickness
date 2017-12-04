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
    
    func createAnimation(atlasName: String) -> [SKTexture]{
        var animation = [SKTexture]()
        let atlas = SKTextureAtlas(named: "\(atlasName)")
        print("\(atlasName): \(atlas.textureNames.count)")
        for index in 1...atlas.textureNames.count{
            let imgName = String(format: "\(atlasName)%01d", index)
            animation += [atlas.textureNamed(imgName)]
        }
        return animation
    }
    
    func playAnimation(){
        let ani = SKAction.animate(with: animation, timePerFrame: 0.04)
        let runAnimationForever = SKAction.repeatForever(ani)
        self.getNode().run(runAnimationForever, withKey: "running")
    }
}
