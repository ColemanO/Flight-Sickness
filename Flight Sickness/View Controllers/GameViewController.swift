//
//  GameViewController.swift
//  Flight Sickness
//
//  Created by Coleman Oei on 10/18/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {

    @IBOutlet weak var pauseOutlet: UIButton!
    @IBOutlet weak var blurBG: UIVisualEffectView!
    @IBOutlet weak var restartOutlet: UIButton!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var HomeOutlet: UIButton!
    @IBOutlet weak var ResumeOutlet: UIButton!
    var gameScene:GameScene!
    var audioPlayer = AVAudioPlayer()
    
    @IBAction func restartButton(_ sender: Any) {
        //gameScene.resetScene()
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
        resetScene()
        HomeOutlet.isHidden = true
        ResumeOutlet.isHidden = true
        restartOutlet.isHidden = true
        stateLabel.isHidden = true
        blurBG.isHidden = true
        pauseOutlet.isHidden = false
    }
    @IBAction func Resume(_ sender: Any) {
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
        HomeOutlet.isHidden = true
        ResumeOutlet.isHidden = true
        restartOutlet.isHidden = true
        stateLabel.isHidden = true
        blurBG.isHidden = true
        pauseOutlet.isHidden = false
        gameScene.view?.isPaused = false
    }
    @IBAction func Home(_ sender: Any) {
        if (audioPlayer.isPlaying) {
            audioPlayer.numberOfLoops = 0
            audioPlayer.pause()
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func Pause(_ sender: Any) {
        if (audioPlayer.isPlaying) {
            audioPlayer.numberOfLoops = 0
            audioPlayer.pause()
        }
        HomeOutlet.isHidden = false
        ResumeOutlet.isHidden = false
        restartOutlet.isHidden = false
        blurBG.isHidden = false
        pauseOutlet.isHidden = true
        stateLabel.isHidden = false
        stateLabel.text = "Pause"
        gameScene.view?.isPaused = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                gameScene = sceneNode
                sceneNode.viewController = self
                
                // Copy gameplay related content over to the scene
                //sceneNode.entities = scene.entities
                //sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                    
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
            }
        }
    }

    func resetScene(){
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                gameScene = sceneNode
                sceneNode.viewController = self
                
                // Copy gameplay related content over to the scene
                //sceneNode.entities = scene.entities
                //sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    func gameOver(score: String){
        if (audioPlayer.isPlaying) {
            audioPlayer.numberOfLoops = 0
            audioPlayer.pause()
        }
        HomeOutlet.isHidden = false
        restartOutlet.isHidden = false
        blurBG.isHidden = false
        pauseOutlet.isHidden = true
        stateLabel.isHidden = false
        stateLabel.text = "Score: \(score)"
        gameScene.view?.isPaused = true
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
