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
        createTable(db)
        insertData()
        performQuery()
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
        
        print("Creating table...")
        do {
            if let db = db {
                
                //try db.run(sample.drop())
                
                try db.run(sample.create(ifNotExists: true) { t in
                    t.column(name)
                    t.column(age)
                    
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
        print("Inserting data...")
        let sample = Table("sample")
        let name = Expression<String>("name")
        let age = Expression<Int64>("age")
        do {
            if let db = db {
                let rowID = try db.run(sample.insert(name <- "John Doe", age <- 26))
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
        
        
        if let db = db {
            for person in db.prepare(sample) {
                print("Name: \(person[name])")
                print("Age: \(person[age])")
            }
        }
    }
    
    
}

