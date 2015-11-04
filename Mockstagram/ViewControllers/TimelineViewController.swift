//
//  TimelineViewController.swift
//  Mockstagram
//
//  Created by Jonathan Wilhite on 10/31/15.
//  Copyright © 2015 Jonathan Wilhite. All rights reserved.
//

import UIKit
import SQLite
import Foundation

class TimelineViewController: UIViewController {
    
    var db: Connection?
    var photoTakingHelper : PhotoTakingHelper?
    @IBOutlet weak var imageView : UIImageView!
    
    //@IBOutlet weak var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        establishConnection()
        //createTable(db)
        //insertData()
        //performQuery()
        //performComplexQuery()
        //performJoinQuery()
        //performAggregateQuery()
        displayImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func takePhoto() {
        
        photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!) { (image : UIImage?) in
            if let image = image {
                let newPost = Post()
                newPost.image = image
                newPost.uploadPost(self.db)
            }
            
        }
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
    
    func createTable(db: Connection?) {
        
        var itWorked = false
        let post = Table("post")
        let user = Expression<String>("user")
        let imageFile = Expression<SQLite.Blob>("imageFile")
        let postID = Expression<Int64>("postID")
        
        print("Creating table...")
        do {
            if let db = db {
                
                //try db.run(post.drop())
                
                try db.run(post.create(ifNotExists: true) { t in
                    t.column(user)
                    t.column(imageFile)
                    t.column(postID, primaryKey: true)
                    
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
        let post = Table("post")
        let imageFile = Expression<SQLite.Blob>("imageFile")
        
        let query = post.select(imageFile).limit(1)
        var imageBlobData : Blob?
        
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        
        var image : UIImage?
        
        dispatch_async(backgroundQueue, {
            if let db = self.db {
                for row in db.prepare(query) {
                    imageBlobData = row[imageFile]
                }
            }
            
            if let imageBlobData = imageBlobData {
                let imageData = NSData(bytes: imageBlobData.bytes, length: imageBlobData.bytes.count)
                image = UIImage(data: imageData)
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageView.image = image
            })
        })
        
    }
    
}

extension TimelineViewController: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is PhotoViewController) {
            takePhoto()
            return false
        } else {
            return true
        }
    }
}
