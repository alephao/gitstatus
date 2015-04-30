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
    
    @IBOutlet weak var loginButton: GitButton!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var data: Data!
    var sendingRequest:Bool = false
    
    var userDefauls = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let login:String = userDefauls.objectForKey("login") as? String {
            self.usernameTextField.text = login
        }
        
        data = Data()
        spinner.hidden = true
        messageLabel.hidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("saveData"), name: "loadedDataFromWeb", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("failToLoad"), name: "failToLoadDataFromWeb", object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func tryLogin(sender: UIButton) {
        self.view.endEditing(true)
        
        if !sendingRequest {
            let userName = self.usernameTextField.text
            let pass = self.passwordTextField.text
            
            data.getRepo(userName, password: pass)
            
            hideStuff()
            
            sendingRequest = true
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func hideStuff () {
        usernameTextField.hidden = true
        passwordTextField.hidden = true
        loginButton.hidden = true
        spinner.startAnimating()
        spinner.hidden = false
    }
    
    func showStuff() {
        usernameTextField.hidden = false
        passwordTextField.hidden = false
        loginButton.hidden = false
        spinner.stopAnimating()
        spinner.hidden = true
    }
    
    func saveData () {
        println("Salvando dados")
        let url = NSURL(string: self.data.avatarUrl)
        
        //SALVAR OS DADOS NO BANCO AQUI, ANTES DE DAR CLEARALL
        self.data.clearAll()
        
        User.sharedInstance.imageData = NSData(contentsOfURL: url!)
        User.sharedInstance.name = self.usernameTextField.text
        
        self.userDefauls.setObject(self.usernameTextField.text, forKey: "login")
        
        self.performSegueWithIdentifier("showMainView", sender: self)
        self.sendingRequest = false
        showStuff()
        passwordTextField.text = ""
    }
    
    func failToLoad () {
        messageLabel.hidden = false
        self.sendingRequest = false
        showStuff()
    }
    
}

