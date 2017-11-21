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
    private var people: [Person]!
    
    private init() {
        // Get a database reference.
        // Needed before we can read/write to/from the firebase database.
        ref = Database.database().reference()
    }
    
    func count()->Int {
        return self.people.count
    }
    
    func getUser(index: Int) -> Person {
        self.people.sort(by: {$0.score > $1.score})
        return self.people[index]
    }
    
    //Go back and figure out why this is not working
    /*func sortUsers(){
        var count:Int = 0
        for i in self.people {
            print(i.score)
            count = count + 1
        }
        self.people.sort(by: {$0.score > $1.score})
        print(count)
    }*/
    
    func findUserBasedOnUsername(username: String) -> Person? {
        if let i = self.people.index(where: { $0.username == username }) {
            return self.people[i]
        }
        return nil
    }
    
    func matchingPassword(username: String, password:String) -> Bool {
        for p in people {
            if (p.username == username && p.password == password) {
                return true
            }
        }
        return false
    }
    
    func loadUsers() {
        // Start with an empty array.
        people = [Person]()
        
        // Fetch the data from Firebase and store it in our internal people array.
        // This is a one-time listener.
        ref.child("people").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get the top-level dictionary.
            let value = snapshot.value as? NSDictionary
            
            if let persons = value {
                // Iterate over the person objects and store in our internal people array.
                for p in persons {
                    let username = p.key as! String
                    let info = p.value as! [String:Any]
                    let password = info["password"]
                    let score = info["score"]
                    let newPerson = Person(username: username, password: password! as! String, score: score as! Int)
                    self.people.append(newPerson)
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func addUser(person: Person) {
        // define array of key/value pairs to store for this person.
        let personRecord = [
            "password": person.password,
            "score":person.score
            ] as [String : Any]
        self.ref.child("people").child(person.username).setValue(personRecord)
        people.append(person)
    }
    
    func updateScore(person:Person, score:Int) {
         let personRecord = [
         "password": person.password,
         "score":score
         ] as [String : Any]
         self.ref.child("people").child(person.username).setValue(personRecord)
         person.score = score
    }
    
    func printAllUsers() {
        for person in people {
            print(person.username)
        }
    }
}

//User class
class Person {
    
    var username: String
    var password: String
    var score:Int
    
    init(username: String, password: String, score:Int) {
        self.username = username
        self.password = password
        self.score = score
    }
}

