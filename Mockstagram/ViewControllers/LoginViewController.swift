//
//  LoginViewController.swift
//  Mockstagram
//
//  Created by Jonathan Wilhite on 11/3/15.
//  Copyright © 2015 Jonathan Wilhite. All rights reserved.
//

import UIKit
import SQLite

class LoginViewController: UIViewController {
    
    var db: Connection?
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var failedLabel: UILabel!
    
    @IBAction func buttonTapped(sender: UIButton) {
        let testUser = usernameTF.text!
        let testPass = passwordTF.text!
        
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
            failedLabel.hidden = true
            performSegueWithIdentifier("LogIn", sender: self)
        } else {
            print("Login failed")
            failedLabel.hidden = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        failedLabel.hidden = true
        establishConnection()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
