//
//  HomeViewController.swift
//  Flight Sickness
//
//  Created by Coleman Oei on 10/27/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController  {

    //var cloudGen = CloudGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cloudGen.genClouds(view: view)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func leaderBoardPressed(_ sender: Any) {
        /*GameCenter.saveHighscore(number: 17)
        let viewController = self.view.window?.rootViewController
        let gcvc = GKGameCenterViewController()
        gcvc.gameCenterDelegate = self
        viewController?.present(gcvc, animated: true, completion: nil)*/
    }
    
}
