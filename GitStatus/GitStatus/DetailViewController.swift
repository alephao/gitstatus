//
//  DetailViewController.swift
//  GitStatus
//
//  Created by Aleph Retamal on 4/30/15.
//  Copyright (c) 2015 Guilherme Ferreira de Souza. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var labelsLabel: UILabel!
    
    var labels:[Label]!
    var thePullRequest:PullRequest!
    var lastLabel:UILabel!
    
    @IBOutlet weak var repoTitle: UILabel!
    @IBOutlet weak var repoRepo: UILabel!
    @IBOutlet weak var repoUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        PullRequest.sharedInstance.titulo = selectedPR.titulo
//        PullRequest.sharedInstance.lastUpdate = selectedPR.lastUpdate
//        PullRequest.sharedInstance.issueUrl = selectedPR.issueUrl
        
        
//        labels = [["color": "f99608", "name": "Bronze 1"], ["color": "f99608", "name": "Bronze 2"], ["color": "f0f908", "name": "Ouro 1"], ["color": "333333", "name": "Teste"], ["color": "333333", "name": "Teste"], ["color": "333333", "name": "Teste"], ["color": "333333", "name": "Teste"], ["color": "333333", "name": "Teste"], ["color": "333333", "name": "Teste"], ["color": "333333", "name": "Teste"]]
        
//        println(thePullRequest)
//        println(labels)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.repoTitle.text = thePullRequest.titulo
        self.repoRepo.text = "mackmobile/\(thePullRequest.titulo)"
        self.repoUser.text = User.sharedInstance.name
        labels = thePullRequest.label.allObjects as! [Label]
        
        var margin:CGFloat = 8.0
        var viewMargins:CGFloat = 32.0
        var viewWidthMinusMargin = self.view.bounds.width - viewMargins
        var labelPaddingX:CGFloat = 6.0
        var labelFullPaddingX:CGFloat = labelPaddingX * 2.0
        var labelPaddingY:CGFloat = 1.0
        var labelFullPaddingY:CGFloat = labelPaddingY * 2.0
        
        var pos_x:CGFloat = 0
        var pos_y:CGFloat = 0
        
        self.lastLabel = labelsLabel
        
        for label in labels {
            let theLabel = UILabel()
            theLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
            theLabel.text = label.nome
            theLabel.backgroundColor = UIColor(hex: label.cor)
            theLabel.textAlignment = .Center
            theLabel.textColor = UIColor.whiteColor()
            theLabel.sizeToFit()
            theLabel.bounds = CGRect(x: 0, y: 0, width: theLabel.bounds.width + labelFullPaddingX, height: theLabel.bounds.height + labelFullPaddingY)
            theLabel.layer.cornerRadius = 4
            
            
            if CGRectGetMinX(self.lastLabel.frame) + self.lastLabel.bounds.width + theLabel.bounds.width + margin > viewWidthMinusMargin {
                
                pos_x = 16
                pos_y = self.lastLabel.bounds.height + self.lastLabel.frame.origin.y + margin
                
                
            } else {
                
                pos_x = self.lastLabel.bounds.width + self.lastLabel.frame.origin.x + margin
                pos_y = self.lastLabel.frame.origin.y
                
            }
            
            theLabel.frame.origin = CGPoint(x: pos_x, y: pos_y)
            
            
            self.view.addSubview(theLabel)
            
            self.lastLabel = theLabel
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
