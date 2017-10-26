//
//  GameScene.swift
//  Flight Sickness
//
//  Created by Coleman Oei on 10/18/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    //swipes
    
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    private var player: Player!
    private var leftAisle:SKSpriteNode!
    private var rightAisle:SKSpriteNode!
    
    
    
    override func didMove(to view: SKView) {
        player = Player(node: self.childNode(withName: "player") as! SKSpriteNode)
        //player = self.childNode(withName: "player") as! SKSpriteNode
        rightAisle = self.childNode(withName: "rightAisle") as! SKSpriteNode
        leftAisle = self.childNode(withName: "leftAisle") as! SKSpriteNode
        swipeRightRec.addTarget(self, action: #selector(GameScene.swipedRight) )
        swipeRightRec.direction = .right
        self.view!.addGestureRecognizer(swipeRightRec)
        
        swipeLeftRec.addTarget(self, action: #selector(GameScene.swipedLeft) )
        swipeLeftRec.direction = .left
        self.view!.addGestureRecognizer(swipeLeftRec)
    }
    
    //swipe funcs
    
    @objc func swipedRight() {
        
        print("Right")
        let moveRight = SKAction.move(to: CGPoint(x: rightAisle.position.x, y: player.getNode().position.y), duration: 0.1)
        player.getNode().run(moveRight)
        
    }
    
    @objc func swipedLeft() {
        let moveLeft = SKAction.move(to: CGPoint(x: leftAisle.position.x, y: player.getNode().position.y), duration: 0.1)
        player.getNode().run(moveLeft)
        print("Left")
    }
    
}

