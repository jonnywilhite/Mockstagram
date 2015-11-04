//
//  Post.swift
//  Mockstagram
//
//  Created by Jonathan Wilhite on 11/3/15.
//  Copyright © 2015 Jonathan Wilhite. All rights reserved.
//

import Foundation
import UIKit
import SQLite

class Post {
    var image: UIImage?
    
    func uploadPost(db: Connection?) {
        
        let post = Table("post")
        let user = Expression<String>("user")
        let imageFile = Expression<SQLite.Blob>("imageFile")
        
        if let image = image {
            let imageData = UIImagePNGRepresentation(image)
            let blob = imageData!.datatypeValue
            
            let qualityOfServiceClass = QOS_CLASS_BACKGROUND
            let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
            
            dispatch_async(backgroundQueue, {
                do {
                    if let db = db {
                        let rowID = try db.run(post.insert(user <- "jonny", imageFile <- blob))
                        print("Inserted ID: \(rowID)")
                    }
                } catch _ {
                    print("Couldn't insert image")
                }
            })
        }
    }
}