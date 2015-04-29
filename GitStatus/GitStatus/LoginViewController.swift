//
//  ViewController.swift
//  GitStatus
//
//  Created by Guilherme Ferreira de Souza on 4/28/15.
//  Copyright (c) 2015 Guilherme Ferreira de Souza. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var data: Data!
    var sendingRequest:Bool = false
    var loadingLayer:CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        data = Data()
    
        loadingLayer = CALayer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func tryLogin(sender: UIButton) {
        if !sendingRequest {
            let userName = self.usernameTextField.text
            let pass = self.passwordTextField.text
            data.getRepo(userName, password: pass)
            
            sendingRequest = true
            createLoadingLayer()
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func createLoadingLayer() {
        
        loadingLayer.bounds = self.view.bounds
        loadingLayer.backgroundColor = UIColor.yellowColor().CGColor
        loadingLayer.position = self.view.center
        self.view.layer.insertSublayer(loadingLayer, atIndex: 10)
        
    }
    
}

