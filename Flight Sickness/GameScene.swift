//
//  GameScene.swift
//  Flight Sickness
//
//  Created by Coleman Oei on 10/18/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

/* bit masks used for detecting collisions */
struct BitMask {
    static let player: UInt32 = 0x1 << 0
    static let gameStopper: UInt32 = 0x1 << 1
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
    private var cart: Cart!
    private var bag: Bag!
    private var scoreLabel = SKLabelNode()
    private var score:Int = 0
    
    var audioPlayer = AVAudioPlayer()
    
    var topScreen: CGFloat{
        get{
            return cam.position.y + (self.size.height/2)
        }
    }
    
    override func didMove(to view: SKView) {
        //set up the player
        player = Player(node: self.childNode(withName: "player") as! SKSpriteNode)
        player.getNode().physicsBody?.categoryBitMask = BitMask.player
        player.getNode().physicsBody?.collisionBitMask = 0
        player.getNode().physicsBody?.contactTestBitMask = BitMask.gameStopper
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
        
        //init cart
        cart = Cart()
        self.addChild(cart)
        cart.position = CGPoint(x: leftAisle.position.x, y: self.topScreen + cart.size.height)
       
        // init bag
        bag = Bag()
        self.addChild(bag)
        //FIXME
        bag.position = CGPoint(x: rightAisle.position.x, y: self.topScreen + bag.size.height)
        Bag.animateBags([bag])
        
        scoreLabel.position = CGPoint(x: self.frame.width / 2, y: self.frame.height - 100)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.white
        self.addChild(scoreLabel)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "background", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.currentTime = 2
        }
        catch {
            print(error)
        }
        
        if (Settings.soundtrack()) {
            audioPlayer.play()
        }
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
        if(cart.position.y < cam.position.y - distanceToOffscreen){
            let ranNum = arc4random_uniform(2)
            if(ranNum == 1){
                cart.position.x = self.rightAisle.position.x
            }else{
                cart.position.x = self.leftAisle.position.x
            }
            cart.position.y = cam.position.y + self.topScreen+cart.size.height //TODO fix this (farther intervals between)
        }
        let delay = SKAction.wait(forDuration: 0.25)
        let incrementScore = SKAction.run ({
            self.score = self.score + 1
            self.scoreLabel.text = "\(self.score)"
        })
        self.run(SKAction.repeatForever(SKAction.sequence([delay,incrementScore])))
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
            seat.physicsBody?.categoryBitMask = BitMask.gameStopper
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
        if (audioPlayer.isPlaying) {
            audioPlayer.pause()
        }
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
        case BitMask.gameStopper:
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

