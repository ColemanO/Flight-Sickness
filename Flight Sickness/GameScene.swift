//
//  GameScene.swift
//  Flight Sickness
//
//  Created by Coleman Oei on 10/18/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import SpriteKit
import GameplayKit

/* bit masks used for detecting collisions */
struct BitMask {
    static let player: UInt32 = 0x1 << 0
    static let seat: UInt32 = 0x1 << 1
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //swipes
    
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    private var player: Player!
    private var leftAisle:SKSpriteNode!
    private var rightAisle:SKSpriteNode!
    private var seat:SKSpriteNode!
    private var cam = SKCameraNode()
    private var seats = [SKSpriteNode]() //TODO: remove this and everything that depends on it
    private var seatIndexToCheck:Int!
    
    private var initialSeatPos:CGFloat!
    private var playerOffset:CGFloat!
    
    var count = 0
    
    override func didMove(to view: SKView) {
        player = Player(node: self.childNode(withName: "player") as! SKSpriteNode)
        player.getNode().physicsBody?.categoryBitMask = BitMask.player
        player.getNode().physicsBody?.collisionBitMask = 0
        player.getNode().physicsBody?.contactTestBitMask = BitMask.seat
        player.getNode().physicsBody?.usesPreciseCollisionDetection = true
        addChild(cam)
        camera = cam
        camera?.zPosition = 1
        playerOffset = cam.position.y - player.getNode().position.y
        
        seat = self.childNode(withName: "seat") as! SKSpriteNode
        seat.isHidden = true
        seat.physicsBody?.categoryBitMask = BitMask.seat
        seat.physicsBody?.collisionBitMask = 0
        seat.physicsBody?.contactTestBitMask = BitMask.player
        seat.physicsBody?.usesPreciseCollisionDetection = true
        initialSeatPos = seat.position.y
        rightAisle = self.childNode(withName: "rightAisle") as! SKSpriteNode
        leftAisle = self.childNode(withName: "leftAisle") as! SKSpriteNode
        swipeRightRec.addTarget(self, action: #selector(GameScene.swipedRight) )
        swipeRightRec.direction = .right
        self.view!.addGestureRecognizer(swipeRightRec)
        
        swipeLeftRec.addTarget(self, action: #selector(GameScene.swipedLeft) )
        swipeLeftRec.direction = .left
        self.view!.addGestureRecognizer(swipeLeftRec)
        
        self.physicsWorld.contactDelegate = self //assign the contact delegate for collisions
        setUpSeats()
        seatIndexToCheck = seats.count - 1
    }
    
    //run after each frame
    override func update(_ currentTime: TimeInterval) {
        let newCenter = player.getNode().position.y + playerOffset
        camera?.position.y = newCenter
        rightAisle.position.y = newCenter
        leftAisle.position.y = newCenter
        let seatToCheck = seats[seatIndexToCheck]
        let distanceToOffscreen = (self.frame.height/2) + seatToCheck.frame.height/2
        if(seatToCheck.position.y < cam.position.y - distanceToOffscreen){
            seatToCheck.position.y = cam.position.y + distanceToOffscreen
            if(seatIndexToCheck == 0){
                seatIndexToCheck = seats.count - 1
            }
            seatIndexToCheck? -= 1
        }
        
        //GET RID OF THIS - TESTING CODE
        count+=1
        
        if (count == 10)
        {
            gameOver()
        }
    }
    
    //set up the seats according to the screen size
    func setUpSeats(){
        let spaceBetweenSeats = player.getNode().frame.height * 3
        let distanceToOffscreen = (self.frame.height/2) + seat.frame.height/2
        var curSeatPos = CGPoint(x: 0, y: distanceToOffscreen)
        while ((curSeatPos.y) > cam.position.y - distanceToOffscreen){
            let seat = SKSpriteNode(imageNamed: "seat")
            seat.setScale(2.5)
            seat.position = curSeatPos
            seat.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "seat"), alphaThreshold: 0, size: seat.size)
            seat.physicsBody?.affectedByGravity = false
            seat.physicsBody?.categoryBitMask = BitMask.seat
            seat.physicsBody?.collisionBitMask = 0
            seat.physicsBody?.contactTestBitMask = BitMask.player
            seat.physicsBody?.usesPreciseCollisionDetection = true
            self.addChild(seat)
            seats.append(seat)
            curSeatPos.y += -((seat.frame.height) + spaceBetweenSeats)
        }
    }
    //called when the user loses
    func gameOver(){
        //present game over screen
        player.getNode().physicsBody?.pinned = true
        let transition = SKTransition.flipHorizontal(withDuration: 0.5)
        let gameOver = SKScene(fileNamed: "GameOverScreen") as! GameOverScreen
        self.view?.presentScene(gameOver, transition: transition)
    }
    
    /* a collision happend */
    func didBegin(_ contact: SKPhysicsContact) {
        print("COLLISION")
        var playerBody: SKPhysicsBody
        var otherBody: SKPhysicsBody
        if (contact.bodyA.categoryBitMask == BitMask.player) {
            playerBody = contact.bodyA
            otherBody = contact.bodyB
        }
        else {
            playerBody = contact.bodyB
            otherBody = contact.bodyA
        }
        assert(playerBody.categoryBitMask == BitMask.player)
        switch (otherBody.categoryBitMask){
        case BitMask.seat:
            //collision happened game over
            gameOver()
            print("game over")
        default:
            break
        }
        
    }
    
    //swipe funcs
    
    @objc func swipedRight() {
        
        print("Right")
        let moveRight = SKAction.moveTo(x: rightAisle.position.x, duration: 0.1)
        player.getNode().run(moveRight)
        
    }
    
    @objc func swipedLeft() {
        let moveLeft = SKAction.moveTo(x: leftAisle.position.x, duration: 0.1)
        player.getNode().run(moveLeft)
        print("Left")
    }
    
}

