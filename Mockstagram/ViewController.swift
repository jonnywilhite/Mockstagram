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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        establishConnection()
        //createTable(db)
        //createAnotherTable(db)
        //insertData()
        //performQuery()
        //performComplexQuery()
        //performJoinQuery()
        performAggregateQuery()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: SQL Stuff
    func establishConnection() {
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        
        print("Connecting to database...")
        do {
            db = try Connection("\(path)/db.sqlite3")
            if db != nil {
                print("Database connected")
            }
        } catch _ {
            print("Unable to connect to database")
        }
    }
    
    func createTable(db: Connection?) {
        var itWorked = false
        let sample = Table("sample")
        let name = Expression<String>("name")
        let age = Expression<Int64>("age")
        let id = Expression<Int64>("id")
        
        print("Creating table...")
        do {
            if let db = db {
                
                //try db.run(sample.drop())
                
                try db.run(sample.create(ifNotExists: true) { t in
                    t.column(name)
                    t.column(age)
                    t.column(id)
                    
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
    
    func createAnotherTable(db: Connection?) {
        var itWorked = false
        let product = Table("product")
        let device = Expression<String>("device")
        let ownerID = Expression<Int64>("ownerID")
        
        print("Creating table...")
        do {
            if let db = db {
                
                //try db.run(sample.drop())
                
                try db.run(product.create(ifNotExists: true) { t in
                    t.column(device)
                    t.column(ownerID)
                    
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
        let product = Table("product")
        let device = Expression<String>("device")
        let ownerID = Expression<Int64>("ownerID")
        do {
            if let db = db {
                let rowID = try db.run(product.insert(device <- "iPhone", ownerID <- 001))
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
    
}

