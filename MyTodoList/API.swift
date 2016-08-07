//
//  API.swift
//  MyTodoList
//
//  Created by Miguh Ruiz on 7/8/16.
//  Copyright © 2016 Miguh Ruiz. All rights reserved.
//

import UIKit

class API {
    
    class func uniqueUsername() -> String {
        if let username = NSUserDefaults.standardUserDefaults().objectForKey("username") {
            return username as! String
        } else {
            let newUsername = generateUsername()
            NSUserDefaults.standardUserDefaults().setObject(newUsername, forKey: "username")
            return newUsername
        }
    }
    
    class func generateUsername() -> String {
        let uuid = NSUUID().UUIDString
        
        return (uuid as NSString).substringToIndex(5)
    }
    
    class func save(item: TodoItem, todoList: TodoList, responseBlock: (NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: "https://pendientesapp.herokuapp.com/todo")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        var dictionary: Dictionary<String, AnyObject> = ["message": item.todo!, "user": self.uniqueUsername()]
        if let date = item.dueDate {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "dd/MM/yyyy HH:mm"
            dictionary["dueDate"] = formatter.stringFromDate(date)
        }
        if let identifier = item.id {
            dictionary["id"] = NSNumber(longLong: identifier)
        }
        
        let data = try! NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions.PrettyPrinted)
        request.HTTPBody = data
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            if let err = error {
                responseBlock(err)
            } else {
                if let d = data {
                    let result = try! NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.AllowFragments)
                    if let id = result["id"] as? Int64 {
                        item.id = id
                        print("id \(id)")
                        todoList.saveItems()
                    }
                }
            }
        }
        task.resume()
    }
    
}
