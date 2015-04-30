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
//            let topBorder = CALayer()
//            topBorder.backgroundColor = UIColor(hex: "333333").CGColor
//            topBorder.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 1)
//            topBorder.position = CGPoint(x: self.view.bounds.width / 2, y: 0)
//            
//            let bottomBorder = CALayer()
//            bottomBorder.backgroundColor = UIColor(hex: "333333").CGColor
//            bottomBorder.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 1)
//            bottomBorder.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height - 1)
//            
//            let theLabel = UILabel()
//            theLabel.text = "4 pull requests em mackmobile"
//            theLabel.font = UIFont(name: "Helvetica", size: 15)
//            theLabel.textColor = UIColor(hex: "888888")
//            theLabel.sizeToFit()
//            
//            headerView.backgroundColor = UIColor.whiteColor()
//            headerView.layer.addSublayer(topBorder)
//            headerView.layer.addSublayer(bottomBorder)
//            headerView.addSubview(theLabel)
//            
//        }
//        
////        headerView.sizeToFit()
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
        
        self.performSegueWithIdentifier("showDetail", sender: self)
        
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
