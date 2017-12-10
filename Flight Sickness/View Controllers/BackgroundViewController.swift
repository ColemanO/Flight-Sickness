//
//  BackgroundViewController.swift
//  
//
//  Created by Roshan Dongre on 11/18/17.
//

import UIKit
import FirebaseDatabase
import Firebase
import GameKit

class BackgroundViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, GKGameCenterControllerDelegate {
    
    static var gameCenter:Bool = false
    @IBOutlet weak var bckTableView: UITableView!
    //var cloudGen = CloudGenerator()
    
    @IBAction func gameCenter(_ sender: Any) {
        authenticatePlayer(completion: {
            () in
                let gcvc = GKGameCenterViewController()
                gcvc.gameCenterDelegate = self
                self.present(gcvc, animated: true, completion: nil)
        })
//            //GameCenter.saveHighscore(number: 3)
//            //let viewController = self.view.window?.rootViewController
//            let gcvc = GKGameCenterViewController()
//            gcvc.gameCenterDelegate = self
//            self.present(gcvc, animated: true, completion: nil)
//            //viewController?.present(gcvc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "backgroundcell", for: indexPath) as UITableViewCell
        //cell.textLabel?.font = UIFont.init(name: "DCCHardware-Condensed", size: 20)
        //cell.detailTextLabel?.font = UIFont.init(name: "DCCHardware-Condensed", size: 20)
        if (indexPath.row < DataStore.shared.count()) {
            cell.textLabel?.text = DataStore.shared.getUser(index: indexPath.row).username
            cell.detailTextLabel?.text = String(DataStore.shared.getUser(index: indexPath.row).score)
        }
        else {
            cell.textLabel?.text = "Empty"
            cell.detailTextLabel?.text = "Empty"
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cloudGen.genClouds(view: view)
        DataStore.shared.loadUsers()
        // Do any additional setup after loading the view.
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(popCurrentViewController))
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem = backButton
        
        let containerView:UIView = UIView(frame:self.bckTableView.frame)
        //self.bckTableView = UITableView(frame: containerView.bounds, style: .plain)
        containerView.backgroundColor = UIColor.clear
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 2
        
        self.bckTableView.layer.cornerRadius = 10
        self.bckTableView.layer.masksToBounds = true
        self.view.addSubview(containerView)
        containerView.addSubview(self.bckTableView)
        
        bckTableView.delegate = self
        bckTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func popCurrentViewController(_ animated: Bool) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.bckTableView.reloadData()
    }

    //Game Center
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    func presentGCBoard()->Void{
        let gcvc = GKGameCenterViewController()
        gcvc.gameCenterDelegate = self
        self.present(gcvc, animated: true, completion: nil)
    }
    
    func authenticatePlayer(completion: () -> Void){
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = {
            (view, error) in
            if view != nil {
                self.present(view!, animated: true, completion: nil)
                BackgroundViewController.gameCenter = true
            }
            else {
                print(GKLocalPlayer.localPlayer().isAuthenticated)
            }
        }
        completion();
    }
    
    class func gameCenterReturn() -> Bool {
        return gameCenter
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
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
