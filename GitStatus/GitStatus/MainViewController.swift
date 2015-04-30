//
//  MainViewController.swift
//  GitStatus
//
//  Created by Aleph Retamal on 4/29/15.
//  Copyright (c) 2015 Guilherme Ferreira de Souza. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func signOut(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return section == 1 ? 3 : 1
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
   
            cell?.title.text = "iDicionario"
            cell?.openedOn.text = "#17 opened on Mar 16 by"
            cell?.userName.text = User.sharedInstance.name
            cell?.repository.text = "mackmobile/test"
            cell?.comments.text = "\(5)"
        
        return indexPath.section == 1 ? cell! : cellProfile!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.section == 1 ? 90 : 180
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView(frame: CGRectZero)
//        
//        if section == 1 {
//
//            headerView.backgroundColor = UIColor.redColor()
//            
//        }
//        
//        return headerView
//    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title:String = ""
        
        if section == 1 {
            title = "4 pull requests em mackmobile"
        }
        
        return title
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
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
