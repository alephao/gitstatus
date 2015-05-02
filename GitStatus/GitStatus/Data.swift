//
//  Data.swift
//  TesteGitStatus
//
//  Created by Gustavo Tiago on 27/04/15.
//  Copyright (c) 2015 Gustavo Tiago. All rights reserved.
//

import Foundation

class Data {
    var dictionary: [AnyObject] = []
    var labelsUrl: [AnyObject] = []
    var labelDictionary: [AnyObject] = []
    var reposName: [AnyObject] = []
    let requestAuth = RequestAuthorization()
    var avatarUrl = ""
    var dic: [String:String] = [:]
    var repoShared: [AnyObject] = []
    var qntComments: [AnyObject] = []
    
    func lookForUserPullUrl(username:String, password:String){
        
        
        var x = 0
        for dics in self.dictionary{
            var string = self.dictionary[x] as! String
            
            var request = self.requestAuth.getRequest(string, username: username,pw:password)
            var error = NSError?()
            var response: NSURLResponse?
            let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
            
            
            var try = NSError?()
            
            let httpResp = response as! NSHTTPURLResponse
            
            var i=0
            if httpResp.statusCode == 200 {
                let dataArr = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: &try) as! Array<NSDictionary>
                
                
                for repo in dataArr {
                    
                    var string = dataArr[i]["user"]! as! NSDictionary
                    //USUARIO VAI AQUI!
                    if(string["login"]!.isEqualToString(username)){
                        
                        var stringLabelUrl = dataArr[i]["issue_url"]! as! String
                        
                        var nomeRepoShared = stringLabelUrl as NSString
                        
                        for reposNome in self.reposName {
                            var repoAux = reposNome as! String
                            if(nomeRepoShared.containsString(repoAux)){
                                nomeRepoShared = repoAux as String
                                var dic = ["nomeRepo": nomeRepoShared, "issueURL": stringLabelUrl]
                                self.repoShared.append(dic)
                            }
                        }
                        
                        
                        
                        var request = self.requestAuth.getRequest(stringLabelUrl, username: username,pw: password)
                        var error = NSError?()
                        var response: NSURLResponse?
                        let urlData = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
                        let httpResp = response as! NSHTTPURLResponse
                        if httpResp.statusCode == 200 {
                            let dataArr = NSJSONSerialization.JSONObjectWithData(urlData!, options: NSJSONReadingOptions.MutableContainers, error: &try) as! NSDictionary
                            
                            var personLabels = dataArr["labels"] as! Array<NSDictionary>
                            
                            var repositorio = dataArr["url"] as! NSString
                            for repo in personLabels{
                                
                                for reposNome in self.reposName {
                                    var repoAux = reposNome as! String
                                    if(repositorio.containsString(repoAux)){
                                        repositorio = repoAux as String
                                        
                                    }
                                    
                                }
                                var dictionary = ["name": repo["name"] as! String, "color": repo["color"] as! String, "repo":repositorio, "issue": stringLabelUrl]
                                labelDictionary.append(dictionary)
                            }
                            var teste = dataArr["comments"] as! NSNumber
                            self.dic["quantidade"] = teste.stringValue
                            self.dic["repo"] = repositorio as String
                            self.qntComments.append(self.dic)
//                            println(self.qntComments)
                        }
                        
                    } ///////
                    
                    i++
                }
                
                
                
            }
            
            let connection = NSURLConnection(request: request, delegate: nil, startImmediately: true)
            
            x++
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("loadedDataFromWeb", object: self)
        
    }
    
    
    
    
    func getRepo(username:String, password:String){
        
        let usuario = username as String
        var request = self.requestAuth.getRequest("https://api.github.com/users/\(usuario)", username: username, pw: password)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            var try = NSError?()
            if(response != nil){
                let httpResponse = response as! NSHTTPURLResponse
                println("Response: \(httpResponse.statusCode)")
                
                
                //PEGA O AVATAR
                if httpResponse.statusCode == 200 {
                    let dataArr = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &try) as! NSDictionary
                    let avatar = dataArr["avatar_url"] as! String
                    self.avatarUrl = avatar
                }
//                println(self.avatarUrl)
                
                
                var request = self.requestAuth.getRequest("https://api.github.com/users/mackmobile/repos", username: username,pw: password)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
                    var try = NSError?()
                    if(response != nil){
                        let httpResponse = response as! NSHTTPURLResponse
                        
                        if httpResponse.statusCode == 200 {
                            let dataArr = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &try) as! Array<NSDictionary>
                            var i=0
                            for repo in dataArr {
                                
                                var string = dataArr[i]["pulls_url"]! as! String
                                var repos = dataArr[i]["name"]! as! String
                                
                                let range = advance(string.endIndex, -9)..<string.endIndex
                                string.removeRange(range)
                                string += "?per_page=100"
                                self.dictionary.append(string)
                                self.reposName.append(repos)
                                i++
                                
                            }
                            
                        }
                        self.lookForUserPullUrl(username, password: password)
                        
                        let connection = NSURLConnection(request: request, delegate: nil, startImmediately: true)
                    }
                }//Request Async
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName("failToLoadDataFromWeb", object: self)
                println("FATAL ERROR")
            }
        }
    } //Funcao termina aqui
    
    
    func clearAll(){
        self.labelDictionary.removeAll(keepCapacity: false)
        self.dictionary.removeAll(keepCapacity: false)
        self.labelsUrl.removeAll(keepCapacity: false)
        self.qntComments.removeAll(keepCapacity: false)
        self.reposName.removeAll(keepCapacity: false)
        self.dic.removeAll(keepCapacity: false)
    }
}