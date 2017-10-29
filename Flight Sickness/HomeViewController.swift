//
//  HomeViewController.swift
//  Flight Sickness
//
//  Created by Coleman Oei on 10/27/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import UIKit
import GameKit

class HomeViewController: UIViewController, GKGameCenterControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        authenticatePlayer()
//        let signIn = authenticatePlayer()
//        if(signIn != nil){
//            print("got in here")
//            self.present(signIn!, animated: true, completion: nil)
//        }else{
//            print("view was NULL")
//        }
        
        //saveHighscore(number: 5)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leaderBoardPressed(_ sender: Any) {
        GameCenter.saveHighscore(number: 17)
        let viewController = self.view.window?.rootViewController
        let gcvc = GKGameCenterViewController()
        gcvc.gameCenterDelegate = self
        viewController?.present(gcvc, animated: true, completion: nil)
    }
    
    //Game Center
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    func authenticatePlayer(){
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {
            (view, error) in
            
            if view != nil {
                
                self.present(view!, animated: true, completion: nil)
                
            }
            else {
                
                print(GKLocalPlayer.localPlayer().isAuthenticated)
                
            }
            
            
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
