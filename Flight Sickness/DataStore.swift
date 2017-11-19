//
//  DataStore.swift
//  Flight Sickness
//
//  Created by Roshan Dongre on 10/31/17.
//  Copyright © 2017 Coleman. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class DataStore {
    
    static let shared = DataStore()
    private var ref: DatabaseReference!
    private var users: [User]!
    
    private init() {
        // Get a database reference.
        // Needed before we can read/write to/from the firebase database.
        ref = Database.database().reference()
    }
    
    func count()->Int {
        return users.count
    }
    
    func getUser(index: Int) -> User {
        return users[index]
    }
    
    func matchingPassword(username: String, password:String) -> Bool {
        for u in users {
            if (u.username == username && u.password == password) {
                return true
            }
        }
        return false
    }
    
    func loadUsers() {
        // Start with an empty array.
        users = [User]()
        
        // Fetch the data from Firebase and store it in our internal people array.
        // This is a one-time listener.
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get the top-level dictionary.
            let value = snapshot.value as? NSDictionary
            
            if let userTemp = value {
                // Iterate over the person objects and store in our internal people array.
                for u in userTemp {
                    //let user = u.value as! [String:String]
                    let username = u.key as! String
                    let password = u.value as! String
                    let newUser = User(username: username, password: password)
                    self.users.append(newUser)
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func addUser(user: User) {
        // define array of key/value pairs to store for this person.
        // Save to Firebase.
        self.ref.child("users").child(user.username).setValue(user.password)
        // Also save to our internal array, to stay in sync with what's in Firebase.
        self.users.append(user)
    }
    
    func printAllUsers() {
        for user in users {
            print(user.username)
        }
    }
    
}

//User class
class User {
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

