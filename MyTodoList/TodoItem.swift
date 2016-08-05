//
//  TodoItem.swift
//  MyTodoList
//
//  Created by Miguh Ruiz on 5/8/16.
//  Copyright © 2016 Miguh Ruiz. All rights reserved.
//

import UIKit

class TodoItem: NSObject, NSCoding {
    
    
    var todo: String?
    
    var dueDate: NSDate?
    
    var image: UIImage?
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        
        if let message = aDecoder.decodeObjectForKey("todo") as? String {
            self.todo = message
        }
        
        if let date = aDecoder.decodeObjectForKey("dueDate") as? NSDate {
            self.dueDate = date
        }
        
        if let img = aDecoder.decodeObjectForKey("image") as? UIImage {
            self.image = img
        }
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let message = self.todo {
            aCoder.encodeObject(message, forKey: "todo")
        }
        
        if let date = dueDate {
            aCoder.encodeObject(date, forKey: "dueDate")
        }
        
        if let img = self.image {
            aCoder.encodeObject(img, forKey: "image")
        }
    }
    
}
