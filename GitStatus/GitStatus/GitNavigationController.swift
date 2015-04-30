//
//  GitNavigationController.swift
//  GitStatus
//
//  Created by Aleph Retamal on 4/30/15.
//  Copyright (c) 2015 Guilherme Ferreira de Souza. All rights reserved.
//

import UIKit

class GitNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var navigationBarAppearance = UINavigationBar.appearance()
//        navigationBarAppearance.tintColor = UIColor(hex: "ffffff")
//        navigationBarAppearance.barTintColor = UIColor(hex: "333333")
        
//        self.navigationBar.backgroundColor = UIColor(hex: "f5f5f5")
        
        self.navigationBar.frame = CGRect(x: 0, y: 0, width: self.navigationBar.bounds.width, height: self.navigationBar.bounds.height + 1)
        
        let borderBottom = CALayer()
        borderBottom.backgroundColor = UIColor(hex: "e5e5e5").CGColor
        borderBottom.bounds = CGRect(x: 0, y: 0, width: self.navigationBar.bounds.width, height: 1)
        borderBottom.position = CGPoint(x: self.navigationBar.center.x, y: self.navigationBar.bounds.height - 1)
        self.navigationBar.layer.addSublayer(borderBottom)

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
