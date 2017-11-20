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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "backgroundcell", for: indexPath) as UITableViewCell
        //cell.textLabel?.font = UIFont.init(name: "Avenir-Heavy", size: 20)
        //cell.detailTextLabel?.font = UIFont.init(name: "Avenir-Heavy", size: 20)
        if (indexPath.row < DataStore.shared.count()) {
            cell.textLabel?.font = UIFont(name:"DCCHardware-Condensed", size:22)
            cell.textLabel?.text = DataStore.shared.getUser(index: indexPath.row).username
            cell.detailTextLabel?.text = DataStore.shared.getUser(index: indexPath.row).password //Need to change this to score
        }
        else {
            cell.textLabel?.text = "Loading"
            cell.detailTextLabel?.text = "Loading"
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(popCurrentViewController))
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem = backButton
        
        let containerView:UIView = UIView(frame:self.bckTableView.frame)
        //self.bckTableView = UITableView(frame: containerView.bounds, style: .plain)
        containerView.backgroundColor = UIColor.clear
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        containerView.layer.shadowOpacity = 1.0
        containerView.layer.shadowRadius = 2
        
        self.bckTableView.layer.cornerRadius = 10
        self.bckTableView.layer.masksToBounds = true
        self.view.addSubview(containerView)
        containerView.addSubview(self.bckTableView)
        
        bckTableView.delegate = self
        bckTableView.dataSource = self
        DataStore.shared.loadUsers()
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
