//
//  PullRequest.swift
//  GitStatus
//
//  Created by Guilherme Ferreira de Souza on 4/30/15.
//  Copyright (c) 2015 Guilherme Ferreira de Souza. All rights reserved.
//

import Foundation
import CoreData

@objc(PullRequest)
class PullRequest: NSManagedObject {

    @NSManaged var titulo: String
    @NSManaged var lastUpdate: NSDate
    @NSManaged var issueUrl: String
    @NSManaged var label: NSSet
    
    func addLabel(moc: NSManagedObjectContext, labelToBeAdded: Label) {
        var labels = self.mutableSetValueForKey("label")
        labels.addObject(labelToBeAdded)
        moc.save(nil)
    }
    
    func removeLabel(moc: NSManagedObjectContext, labelToBeRemoved: Label) {
        var labels = self.mutableSetValueForKey("label")
        var labelInstanceToRemove = Label()
        for lblItem in labels {
            var currentLabel = lblItem as! Label
            if currentLabel.nome == labelToBeRemoved.nome && currentLabel.cor == currentLabel.cor {
                labels.removeObject(currentLabel)
                break
            }
        }
        
        moc.save(nil)
    }
}


