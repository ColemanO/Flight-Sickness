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
        var diverAnimation = [SKTexture]()
        let diverAtlas = SKTextureAtlas(named: "\(atlasName)")
        print("\(atlasName): \(diverAtlas.textureNames.count)")
        for index in 1...diverAtlas.textureNames.count{
            let imgName = String(format: "\(atlasName)%01d", index)
            diverAnimation += [diverAtlas.textureNamed(imgName)]
        }
        return diverAnimation
    }
    
    func playAnimation(){ //TODO maybe clean this up and move it to a different file
        let ani = SKAction.animate(with: animation, timePerFrame: 0.075)
        let runAnimationForever = SKAction.repeatForever(ani)
        self.getNode().run(runAnimationForever)
    }
}
