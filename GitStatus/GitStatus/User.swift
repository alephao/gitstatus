//
//  User.swift
//  GitStatus
//
//  Created by Aleph Retamal on 4/29/15.
//  Copyright (c) 2015 Guilherme Ferreira de Souza. All rights reserved.
//

import UIKit

class User: NSObject {
    var name:String?
    var imageData:NSData?

    private override init() {
//        self.name = name
//        self.imageData = imageData
    }
    
    class var sharedInstance : User {

        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : User? = nil
        }

        dispatch_once(&Static.onceToken) {
            Static.instance = User()
        }
        
        return Static.instance!
    }

}
