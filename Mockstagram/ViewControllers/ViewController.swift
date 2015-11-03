//
//  ViewController.swift
//  Mockstagram
//
//  Created by Jonathan Wilhite on 10/31/15.
//  Copyright © 2015 Jonathan Wilhite. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    var db: Connection?
    
    @IBOutlet weak var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        establishConnection()
        logIn()
        //createTable(db)
        //insertData()
        //performQuery()
        //performComplexQuery()
        //performJoinQuery()
        //performAggregateQuery()
        //displayImage()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: SQL Stuff
    func establishConnection() {
        
        print("Connecting to database...")
        do {
            db = try Connection("/users/jonathanwilhite/Desktop/Mockstagram.db")
            if db != nil {
                print("Database connected")
            }
        } catch _ {
            print("Unable to connect to database")
        }
    }
    
    func logIn() {
        let testUser = "jonny"
        let testPass = "test"
        
        let user = Table("user")
        let username = Expression<String>("username")
        let password = Expression<String>("password")
        
        let query = user.select(username, password).filter(username == testUser && password == testPass).limit(1)
        var i = 0
        if let db = db {
            for person in db.prepare(query) {
                print("Logging in as \(person[username])")
                i++
            }
        }
        if i == 1 {
            print("Logged in successfully")
        } else {
            print("Login failed")
        }
    }
    
    func createTable(db: Connection?) {
        
        var itWorked = false
        let flag = Table("flag")
        let fromUser = Expression<String>("fromUser")
        let toPost = Expression<Int64>("toPost")
        
        print("Creating table...")
        do {
            if let db = db {
                
                //try db.run(sample.drop())
                
                try db.run(flag.create(ifNotExists: true) { t in
                    t.column(fromUser)
                    t.column(toPost)
                    
                    itWorked = true;
                    })
            } else {
                print("Didn't work")
                itWorked = false
            }
        } catch _ {
            print("Unable to create table")
            itWorked = false;
        }
        
        if itWorked {
            print("Table created")
        }
    }
    
    func insertData() {
//        print("Inserting data...")
//        let sample = Table("sample")
//        let name = Expression<String>("name")
//        let age = Expression<Int64>("age")
//        let id = Expression<Int64>("id")
//        do {
//            if let db = db {
//                let rowID = try db.run(sample.insert(name <- "Jane Doe", age <- 27, id <- 002))
//                print("Inserted ID: \(rowID)")
//            }
//        } catch _ {
//            print("Could not insert data")
//        }
        
        print("Inserting data...")
        let image = Table("image")
        let url = Expression<String>("url")
        let imageURL = "http://i.imgur.com/PxYPizA.png"
        do {
            if let db = db {
                let rowID = try db.run(image.insert(url <- imageURL))
                print("Inserted ID: \(rowID)")
            }
        } catch _ {
            print("Could not insert data")
        }
    }
    
    func performQuery() {
        print("Generating query...")
        let sample = Table("sample")
        let name = Expression<String>("name")
        let age = Expression<Int64>("age")
        let id = Expression<Int64>("id")
        
        if let db = db {
            for person in db.prepare(sample) {
                print("Name: \(person[name]), Age: \(person[age]), ID: \(person[id])")
            }
        }
    }
    
    func performComplexQuery() {
        print("Generating query...")
        let sample = Table("sample")
        let name = Expression<String>("name")
        let age = Expression<Int64>("age")
        
        let query = sample.select(name, age).filter(age < 31).order(age.desc)
        
        if let db = db {
            for person in db.prepare(query) {
                print("Name: \(person[name]), Age: \(person[age])")
            }
        }
    }
    
    func performJoinQuery() {
        print("Generating query...")
        let sample = Table("sample")
        let name = Expression<String>("name")
        let age = Expression<Int64>("age")
        let id = Expression<Int64>("id")
        
        let product = Table("product")
        let device = Expression<String>("device")
        let ownerID = Expression<Int64>("ownerID")
        
        let query = sample.join(product, on: id == ownerID)
        
        if let db = db {
            for person in db.prepare(query) {
                print("Name: \(person[name]), Age: \(person[age]), Device: \(person[device])")
            }
        }
        
    }
    
    func performAggregateQuery() {
        print("Generating query...")
        let sample = Table("sample")
        //let name = Expression<String>("name")
        //let age = Expression<Int64>("age")
        //let id = Expression<Int64>("id")
        
        if let db = db {
            let count = db.scalar(sample.count)
            print(count)
        }
    }
    
    func displayImage() {
        let image = Table("image")
        let url = Expression<String>("url")
        var imageURLString : String?
        
        if let db = db {
            for pic in db.prepare(image) {
                imageURLString = pic[url]
            }
        }
        
        if let imageURLString = imageURLString {
            let imageURL = NSURL(string: imageURLString)
            let imageData = NSData(contentsOfURL: imageURL!)
            let image = UIImage(data: imageData!)
            imageView.image = image!
        }
    }
    
}

