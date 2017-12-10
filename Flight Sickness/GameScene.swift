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
    static let powerUp: UInt32 = 0x1 << 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {

    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    private var player: Player!
    private var leftAisle:SKSpriteNode!
    private var rightAisle:SKSpriteNode!
    private var cam = SKCameraNode()
    private var seats = [SKSpriteNode]()
    private var obstacles = [Obstacle]()
    private var seatIndexToCheck:Int!
    private var topSeatIndexToCheck:Int!
    private var playerOffset:CGFloat!
    private var scoreLabel = SKLabelNode()
    private var ticks:Int64 = 0
    private var gen:ObstacleGenerator!
    var viewController: GameViewController!
    private let scoreLabelBuffer:CGFloat = 175
    private var spaceBetweenSeats:CGFloat!
    private var peanutVar:Int64 = 100
    private var toiletSprite:SKSpriteNode!
    private var isInvuln:Bool = false
    private var counter:Int64 = 0
    private var plusFifty: SKLabelNode!
    
    var person:Person!
    var crashPlayer = AVAudioPlayer()
    
    var topScreen: CGFloat{
        get{
            return cam.position.y + (self.size.height/2)
        }
    }
    
    var bottomScreen: CGFloat{
        get{
            return cam.position.y - (self.size.height/2)
        }
    }
    
    override func didMove(to view: SKView) {
        // FIXME
        GeneratorConfig.config = GeneratorConfig()
        person = DataStore.shared.findUserBasedOnUsername(username: Settings.username())
        
        //set up the player
        player = Player(node: self.childNode(withName: "player") as! SKSpriteNode)
        player.getNode().physicsBody?.categoryBitMask = BitMask.player
        player.getNode().physicsBody?.collisionBitMask = 0
        player.getNode().physicsBody?.contactTestBitMask = 0//BitMask.gameStopper
        player.getNode().physicsBody?.usesPreciseCollisionDetection = true
        
        spaceBetweenSeats = player.getNode().frame.height * 0.7
        
        plusFifty = SKLabelNode(fontNamed: "DDCHardware-Regular")
        plusFifty.text = "+\(peanutVar)"
        plusFifty.fontSize = 75
        plusFifty.fontColor = SKColor.white
        plusFifty.position = CGPoint(x: 0, y: 0)
        plusFifty.zPosition = 1
        addChild(plusFifty)
        plusFifty.isHidden = true
        
        //set up the camera
        addChild(cam)
        camera = cam
        camera?.zPosition = 1
        
        //offset of the player from the camera's center
        playerOffset = cam.position.y - player.getNode().position.y
        
        //set aisles up
        rightAisle = self.childNode(withName: "rightAisle") as! SKSpriteNode
        leftAisle = self.childNode(withName: "leftAisle") as! SKSpriteNode
        
        // set up ObstacleGenerator
        gen = ObstacleGenerator([Bag.self, Cart.self, Peanut.self, ToiletPaper.self], [rightAisle.position.x, leftAisle.position.x])

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
        topSeatIndexToCheck = 0;
        scoreLabel.position = CGPoint(x: 0, y: self.topScreen - scoreLabelBuffer)
        scoreLabel.fontName = "DDCHardware-Condensed"
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = UIColor.white
        scoreLabel.zPosition = 2
        scoreLabel.text = String(0)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        toiletSprite = SKSpriteNode(imageNamed: "toiletpaper")
        toiletSprite.size.width = 75
        toiletSprite.size.height = 75
        toiletSprite.isHidden = true
        toiletSprite.position = CGPoint(x: cam.position.x + 2 * scoreLabelBuffer, y: self.topScreen - scoreLabelBuffer/3)
        self.addChild(toiletSprite)
        
        do {
            crashPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "crash", ofType: "mp3")!))
            crashPlayer.prepareToPlay()
            crashPlayer.numberOfLoops = 0
            crashPlayer.currentTime = 2.3
            crashPlayer.rate = 1.5
        }
        catch {
            print(error)
        }
    }
    
    //run after each frame
    override func update(_ currentTime: TimeInterval) {
        let newCenter = player.getNode().position.y + playerOffset //calculates the center relative to the center
        //update positions based on where the player moved
        camera?.position.y = newCenter
        rightAisle.position.y = newCenter
        leftAisle.position.y = newCenter
        scoreLabel.position = CGPoint(x: 0, y: self.topScreen - scoreLabelBuffer)
        toiletSprite.position = CGPoint(x: cam.position.x + 2 * scoreLabelBuffer, y: self.topScreen - scoreLabelBuffer/3)
        plusFifty.position = cam.position
        
        //check if the bottom seat is still on the screen
        let seatToCheck = seats[seatIndexToCheck]
        let distanceToOffscreen = (self.frame.height/2) + seatToCheck.frame.height/2
        if (isOffscreen(sprite: seatToCheck)){
            let topSeat = seats[topSeatIndexToCheck]
            seatToCheck.position.y = topSeat.position.y + spaceBetweenSeats + topSeat.frame.height
            //seatToCheck.position.y = seatToCheck.position.y + 2 * distanceToOffscreen
            topSeatIndexToCheck = seatIndexToCheck
            if(seatIndexToCheck == 0){
                seatIndexToCheck = seats.count
            }
            seatIndexToCheck? -= 1
            //topSeatIndexToCheck = (topSeatIndexToCheck + 1) % seats.count
        }
        self.ticks += 1
        // TODO: add randomness to interval
        // change interval depending on screen size
        if (self.ticks % GeneratorConfig.config.generatorTicks == 0) {
            GeneratorConfig.config.updateTick()
            //print(GeneratorConfig.config.generatorTicks)
            gen.collectObstacles(bottomScreen: bottomScreen)
            let obs = gen.next(topScreen: self.topScreen, bottomScreen: self.bottomScreen)
            obstacles.append(obs)
            self.addChild(obs)
            obs.animate()
        }
        //self.scoreLabel.text = "\(Int(self.cam.position.y) )"
        self.scoreLabel.text = "\(Int(self.scoreLabel.text!)! + (Int(1)))"
        
        counter+=1
        if (counter == 500) {
            toiletSprite.isHidden = true
            isInvuln = false
            player.getNode().alpha = 1
        }
    }

    func isOffscreen(sprite: SKSpriteNode)->Bool{
        let distanceToOffscreen = (self.frame.height/2) + sprite.frame.height/2
        return sprite.position.y < (cam.position.y - distanceToOffscreen)
    }

    func resetScene(){
        let myScene = GameScene(size: self.size)
        myScene.scaleMode = self.scaleMode
        self.view?.presentScene(myScene)
        //let scene = GameScene(size: self.size)
        //self.view?.presentScene(scene)
    }
    
    //set up the seats according to the screen size
    func setUpSeats(){
        let seat = SKSpriteNode(imageNamed: "seat")
        var s = Seat()
        seat.setScale(2.5)
        let distanceToOffscreen = (self.frame.height/2) + seat.frame.height/2
        var curSeatPos = CGPoint(x: 0, y: distanceToOffscreen)
        while ((curSeatPos.y) > cam.position.y - distanceToOffscreen){
            s = Seat()
            s.position = curSeatPos
            self.addChild(s)
            seats.append(s)
            curSeatPos.y += -((seat.frame.height) + spaceBetweenSeats)
        }
        
    }
    //called when the user loses
    func gameOver(){
        print(BackgroundViewController.gameCenter)
        if(BackgroundViewController.gameCenter){
            GameCenter.saveHighscore(number: Int(self.scoreLabel.text!)!)
        }
        if (person.score < Int(self.scoreLabel.text!)!) {
            DataStore.shared.updateScore(person: person, score: Int(self.scoreLabel.text!)!)
        }
        viewController.gameOver(score: self.scoreLabel.text!) //TODO is there a less jank way of doing this?
    }
    
    // a collision happened
    func didBegin(_ contact: SKPhysicsContact) {
        crashPlayer.currentTime = 2.3
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
            print("Reached Here")
            if (!isInvuln) {
                //Play crash noise
                if (Settings.soundEffects() && !crashPlayer.isPlaying) {
                    crashPlayer.play()
                }
                //ran into seat game should be over
                gameOver()
            }
            break
        case BitMask.powerUp:
            self.gen.collectObstacle(otherBody.node!)
            switch (otherBody.node!) {
            case is Peanut:
                self.scoreLabel.text = "\(Int(self.scoreLabel.text!)!.advanced(by: Int(peanutVar)))"
                print("got peanut!")
                let unhide  = SKAction.run{self.plusFifty.isHidden = false}
                let visable = SKAction.fadeIn(withDuration: 0)
                let fade = SKAction.fadeOut(withDuration: 1)
                
                let group = SKAction.group([unhide, visable])
                plusFifty.run(group)
                plusFifty.run(fade)
                break
            case is ToiletPaper:
                isInvuln = true
                counter = 0
                //show the toilet paper
                player.getNode().alpha = 0.5
                //toiletSprite.isHidden = false
                print("got paper!")
                break
            default:
                break
            }
        default:
            break
        }
    }
    
    //swipes
    @objc func swipedRight() {
        player.jump(isLeft: false)
        let moveRight = SKAction.moveTo(x: rightAisle.position.x - 40, duration: 0.1)
        let playAni = SKAction.run {
            self.player.playAnimation()
        }
        let sequence = SKAction.sequence([moveRight, playAni])
        player.getNode().run(sequence)
        
    }
    
    @objc func swipedLeft() {
        player.jump(isLeft: true)
        let moveLeft = SKAction.moveTo(x: leftAisle.position.x - 40, duration: 0.1)
        let playAni = SKAction.run {
            self.player.getNode().xScale = -self.player.getNode().xScale
            self.player.playAnimation()
        }
        let sequence = SKAction.sequence([moveLeft, playAni])
        player.getNode().run(sequence)
    }
}

