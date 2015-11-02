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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var db: Connection?
        var itWorked = false
        
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
        
        let sample = Table("sample")
        let name = Expression<String>("name")
        let age = Expression<Int64>("age")
        
        print("Creating table...")
        do {
            if let db = db {
                
                //try db.run(sample.drop())
                
                try db.run(sample.create { t in
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

