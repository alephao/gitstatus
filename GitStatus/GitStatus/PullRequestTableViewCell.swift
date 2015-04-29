//
//  PullRequestTableViewCell.swift
//  GitStatus
//
//  Created by Aleph Retamal on 4/29/15.
//  Copyright (c) 2015 Guilherme Ferreira de Souza. All rights reserved.
//

import UIKit

class PullRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var openedOn: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var repository: UILabel!
    @IBOutlet weak var comments: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }

}
