//
//  BackgroundViewController.swift
//  
//
//  Created by Roshan Dongre on 11/18/17.
//

import UIKit
import FirebaseDatabase
import Firebase

class BackgroundViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var bckTableView: UITableView!
    var cloudGen = CloudGenerator()
    
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
        cloudGen.genClouds(view: view)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
