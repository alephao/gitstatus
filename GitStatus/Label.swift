//
//  Label.swift
//  GitStatus
//
//  Created by Guilherme Ferreira de Souza on 4/30/15.
//  Copyright (c) 2015 Guilherme Ferreira de Souza. All rights reserved.
//

import Foundation
import CoreData

@objc(Label)
class Label: NSManagedObject {

    @NSManaged var cor: String
    @NSManaged var nome: String
    @NSManaged var pull_request: PullRequest //NSManagedObject

}
