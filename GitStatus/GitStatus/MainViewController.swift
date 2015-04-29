//
//  MainViewController.swift
//  GitStatus
//
//  Created by Aleph Retamal on 4/29/15.
//  Copyright (c) 2015 Guilherme Ferreira de Souza. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func signOut(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userAvatar.image = UIImage(data: User.sharedInstance.imageData!)
        usernameLabel.text = User.sharedInstance.name
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:PullRequestTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier("Cell") as? PullRequestTableViewCell

        if cell != nil {
            cell = PullRequestTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
//        cell?.title.text = "iDicionario"
//        cell?.openedOn.text = "#17 opened on Mar 16 by"
//        cell?.userName.text = User.sharedInstance.name
//        cell?.repository.text = "mackmobile/test"
//        cell?.comments.text = "\(5)"
        
        return UITableViewCell()
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
