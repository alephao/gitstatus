//
//  PullRequestManager.swift
//  GitStatus
//
//  Created by Guilherme Ferreira de Souza on 4/29/15.
//  Copyright (c) 2015 Guilherme Ferreira de Souza. All rights reserved.
//

import UIKit
import CoreData

public class PullRequestManager {
    
    static let sharedInstance:PullRequestManager = PullRequestManager()
    static let entityName:String = "PullRequest"
    
    lazy var managedContext: NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
    }()
    
    private init() {}
    
    func createPullRequest(titulo: String, issueUrl: String) -> PullRequest {
        
        
        let pullReqEntityDescription = NSEntityDescription.entityForName(PullRequestManager.entityName, inManagedObjectContext: managedContext)
        var newPullReq = PullRequest(entity: pullReqEntityDescription!, insertIntoManagedObjectContext: managedContext)

//        let newPullReq = NSEntityDescription.insertNewObjectForEntityForName("PullRequest", inManagedObjectContext: managedContext) as! PullRequest
        newPullReq.lastUpdate = NSDate()
        newPullReq.titulo = titulo
        newPullReq.issueUrl = issueUrl
        
//        for lblItem in pullReq.label {
//            newPullReq.addLabel(managedContext, labelToBeAdded: lblItem as! Label)
//        }
        
        managedContext.save(nil)
        
        return newPullReq
        
    }
    
    func deletePullRequest(pullReqToBeDeleted: PullRequest) {
        
        managedContext.deleteObject(pullReqToBeDeleted)
        managedContext.save(nil)
    }
    
    func addLabelToPullRequest(pullReq: PullRequest ,label: Label) {
        pullReq.addLabel(managedContext, labelToBeAdded: label)
    }
    
    func removeLabelFromPullRequest(pullReq: PullRequest, label: Label) {
        pullReq.removeLabel(managedContext, labelToBeRemoved: label)
    }
    
    func resetPullRequests() {
        let fetchRequest = NSFetchRequest(entityName: PullRequestManager.entityName)
        var erro = NSErrorPointer()
        let fetchedResults: NSArray = managedContext.executeFetchRequest(fetchRequest, error: erro)!
        
        if fetchedResults.count > 0 {
            let listaResultados = fetchedResults
            for pullReqItem in listaResultados {
                deletePullRequest(pullReqItem as! PullRequest)
            }
        }
        
    }
}
