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

    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    private var player: Player!
    private var leftAisle:SKSpriteNode!
    private var rightAisle:SKSpriteNode!
    private var cam = SKCameraNode()
    private var seats = [SKSpriteNode]()
    private var seatIndexToCheck:Int!
    private var playerOffset:CGFloat!
    
    override func didMove(to view: SKView) {
        //set up the player
        player = Player(node: self.childNode(withName: "player") as! SKSpriteNode)
        player.getNode().physicsBody?.categoryBitMask = BitMask.player
        player.getNode().physicsBody?.collisionBitMask = 0
        player.getNode().physicsBody?.contactTestBitMask = BitMask.seat
        player.getNode().physicsBody?.usesPreciseCollisionDetection = true
        
        //set up the camera
        addChild(cam)
        camera = cam
        camera?.zPosition = 1
        
        //offset of the player from the camera's center
        playerOffset = cam.position.y - player.getNode().position.y
        
        //set aisles up
        rightAisle = self.childNode(withName: "rightAisle") as! SKSpriteNode
        leftAisle = self.childNode(withName: "leftAisle") as! SKSpriteNode
        
        //set up swipe recognizers
        swipeRightRec.addTarget(self, action: #selector(GameScene.swipedRight) )
        swipeRightRec.direction = .right
        self.view!.addGestureRecognizer(swipeRightRec)
        
        swipeLeftRec.addTarget(self, action: #selector(GameScene.swipedLeft) )
        swipeLeftRec.direction = .left
        self.view!.addGestureRecognizer(swipeLeftRec)
        
        //assign contact delegate for collisions
        self.physicsWorld.contactDelegate = self
        
        //initialize all of the seats
        setUpSeats()
        seatIndexToCheck = seats.count - 1 //keeps index of the bottom most seat on the screen
    }
    
    //run after each frame
    override func update(_ currentTime: TimeInterval) {
        let newCenter = player.getNode().position.y + playerOffset //calculates the center relative to the center
        //update positions based on where the player moved
        camera?.position.y = newCenter
        rightAisle.position.y = newCenter
        leftAisle.position.y = newCenter
        
        //check if the bottom seat is still on the screen
        let seatToCheck = seats[seatIndexToCheck]
        let distanceToOffscreen = (self.frame.height/2) + seatToCheck.frame.height/2
        if(seatToCheck.position.y < cam.position.y - distanceToOffscreen){
            seatToCheck.position.y = cam.position.y + distanceToOffscreen
            if(seatIndexToCheck == 0){
                seatIndexToCheck = seats.count - 1
            }
            seatIndexToCheck? -= 1
        }
    }
    
    //set up the seats according to the screen size
    func setUpSeats(){
        let spaceBetweenSeats = player.getNode().frame.height * 3
        var seat = SKSpriteNode(imageNamed: "seat")
        seat.setScale(2.5)
        let distanceToOffscreen = (self.frame.height/2) + seat.frame.height/2
        var curSeatPos = CGPoint(x: 0, y: distanceToOffscreen)
        while ((curSeatPos.y) > cam.position.y - distanceToOffscreen){
            seat = SKSpriteNode(imageNamed: "seat")
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
        //TODO: present game over screen
        player.getNode().physicsBody?.pinned = true
    }
    
    // a collision happend
    func didBegin(_ contact: SKPhysicsContact) {
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
        switch (otherBody.categoryBitMask){
        case BitMask.seat:
            //ran into seat game should be over
            gameOver()
        default:
            break
        }
    }
    
    //swipes
    @objc func swipedRight() {
        let moveRight = SKAction.moveTo(x: rightAisle.position.x, duration: 0.1)
        player.getNode().run(moveRight)
    }
    
    @objc func swipedLeft() {
        let moveLeft = SKAction.moveTo(x: leftAisle.position.x, duration: 0.1)
        player.getNode().run(moveLeft)
    }
    
}

