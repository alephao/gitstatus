//
//  RequestAuthorization.swift
//  TesteGitStatus
//
//  Created by Gustavo Tiago on 29/04/15.
//  Copyright (c) 2015 Gustavo Tiago. All rights reserved.
//

import Foundation

class RequestAuthorization{
    
    func getRequest(url: String, username: String, pw: String) -> NSMutableURLRequest{
        let username = username as String
        let password = pw as String
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        // create the request
        let url = NSURL(string: url)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        return request
    }
    
}