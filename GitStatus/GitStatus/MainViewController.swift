//
//  MainViewController.swift
//  GitStatus
//
//  Created by Aleph Retamal on 4/29/15.
//  Copyright (c) 2015 Guilherme Ferreira de Souza. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pullRequests = [NSManagedObject]()
    var selectedRow = 0
    
    @IBAction func signOut(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        //colocar um îfi pra se o usuario mete a fita do rimeimber do loguin
        PullRequestManager.sharedInstance.resetPullRequests()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"PullRequest")
        
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            self.pullRequests = results
            let tst = self.pullRequests[0] as! PullRequest
            println(tst.titulo)
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        
//        if User.sharedInstance.name != nil {
//            userAvatar.image = UIImage(data: User.sharedInstance.imageData!)
//            usernameLabel.text = User.sharedInstance.name
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? pullRequests.count : 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        
        var cellProfile:ProfileTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier("ProfileCell") as? ProfileTableViewCell
        
        if cellProfile == nil {
            
            cellProfile = ProfileTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            
        }
        
        cellProfile?.selectionStyle = .None
        
        if User.sharedInstance.name != nil {
            cellProfile?.avatar.image = UIImage(data: User.sharedInstance.imageData!)
            cellProfile?.username.text = User.sharedInstance.name
        }
        
        var cell:PullRequestTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier("Cell") as? PullRequestTableViewCell
   
            if cell == nil {
  
                cell = PullRequestTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
   
            }
        
        
        if indexPath.section == 1 {
            println(indexPath.row)
            let currentPullRequest = pullRequests[indexPath.row] as! PullRequest
            println(currentPullRequest.titulo)
//            println(currentPullRequest)
            
            cell?.title.text = currentPullRequest.titulo
            cell?.openedOn.text = "#17 opened on Mar 16 by"
            cell?.userName.text = User.sharedInstance.name
            cell?.repository.text = "mackmobile/test"
            cell?.comments.text = "\(5)"
        }
        
        return indexPath.section == 1 ? cell! : cellProfile!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.section == 1 ? 90 : 180
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title:String = ""
        
        if section == 1 {
            title = "\(self.pullRequests.count) pull requests em mackmobile"
        }
        
        return title
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("showDetail", sender: self)
        self.selectedRow = indexPath.row
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! DetailViewController
        let teste = pullRequests[self.selectedRow] as! PullRequest
        println("titulo: \(teste.titulo)")
        println("labels: \(teste.label)")
        destination.thePullRequest = pullRequests[self.selectedRow] as! PullRequest
    }

}
