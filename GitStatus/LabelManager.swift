//
//  LabelManager.swift
//  GitStatus
//
//  Created by Guilherme Ferreira de Souza on 4/29/15.
//  Copyright (c) 2015 Guilherme Ferreira de Souza. All rights reserved.
//

import UIKit
import CoreData

public class LabelManager {
    
    static let sharedInstance:LabelManager = LabelManager()
    static let entityName:String = "Label"
    
    lazy var managedContext: NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
    }()
    
    private init() {}
    
    func getLabel(nome: String, cor: String) -> Label {
        

        let request = NSFetchRequest(entityName: LabelManager.entityName)
        let nomePredicate = NSPredicate(format: "nome = %@", nome)
        let corPredicate = NSPredicate(format: "cor = %@", cor)
        request.predicate = NSCompoundPredicate.andPredicateWithSubpredicates([nomePredicate, corPredicate])
        var erro = NSErrorPointer()
        
        let fetchedResults: NSArray = managedContext.executeFetchRequest(request, error: erro)!
        
        if fetchedResults.count > 0 {
            for registry in fetchedResults {
            
                return fetchedResults.firstObject as! Label
            }
        }
        else {
    
            let labelEntityDescription = NSEntityDescription.entityForName(LabelManager.entityName, inManagedObjectContext: managedContext)
            var caughtLabel = Label(entity: labelEntityDescription!, insertIntoManagedObjectContext: managedContext)
            caughtLabel.nome = nome
            caughtLabel.cor = cor
            
            managedContext.save(nil)
            
            return caughtLabel
            
        }
        
        return Label()
    }
    
    func deleteLabel(labelToBeDeleted: Label) {
        
        managedContext.deleteObject(labelToBeDeleted)
        managedContext.save(nil)
    }
    
    func resetLabels() {
        let fetchRequest = NSFetchRequest(entityName: LabelManager.entityName)
        var erro = NSErrorPointer()
        let fetchedResults: NSArray = managedContext.executeFetchRequest(fetchRequest, error: erro)!
        
        if fetchedResults.count > 0 {
            let listaResultados = fetchedResults
            for lblItem in listaResultados {
                deleteLabel(lblItem as! Label)
            }
        }
        
    }
    
    
   
}
