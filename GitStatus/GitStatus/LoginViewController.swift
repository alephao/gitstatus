//
//  ViewController.swift
//  GitStatus
//
//  Created by Guilherme Ferreira de Souza on 4/28/15.
//  Copyright (c) 2015 Guilherme Ferreira de Souza. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: GitButton!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var switchDisplay: UISwitch!
    @IBOutlet weak var messageLabel: UILabel!
    
    var labelDictionary: [AnyObject] = []
    var qntComments: [AnyObject] = []
    
    var labelCoreDataInstance = LabelManager.sharedInstance
    
    var data: Data!
    var sendingRequest:Bool = false
    
    var error:NSError?
    
    var userDefauls = NSUserDefaults.standardUserDefaults()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
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
        self.labelDictionary = self.data.labelDictionary
        self.qntComments = self.data.qntComments
        //        println(self.data.repoShared)
        
        User.sharedInstance.imageData = NSData(contentsOfURL: url!)
        User.sharedInstance.name = self.usernameTextField.text
        
        self.userDefauls.setObject(self.usernameTextField.text, forKey: "login")
        
        
        var x =  self.userDefauls.boolForKey("\(User.sharedInstance.name)")
        
        
        if(x == false){
            var nome =  ""
            var color = ""
            var repos = ""
            var issue = ""
            var i = 0
            var qntComentarios:NSNumber = 0
            
            for repo in self.data.repoShared{
                
                repos = repo["nomeRepo"] as! String
                issue = repo["issueURL"] as! String
                
                var repoQntComent = self.data.qntComments[i]["repo"] as! String
                
                if(repoQntComent == repos){
                    let formatter = NSNumberFormatter()
                    formatter.numberStyle = NSNumberFormatterStyle.NoStyle;
                    var x = self.data.qntComments[i]["quantidade"] as! String
                    if let number = formatter.numberFromString(x) {
                        qntComentarios = number
                    }
                }
                
                i++
                
                var pullRequestCoreDataInstance = PullRequestManager.sharedInstance.createPullRequest(repos, issueUrl: issue, numeroComentarios: qntComentarios)
                
                
                for label in self.labelDictionary {
                    
                    nome =  label["name"] as! String
                    color = label["color"] as! String
                    var repoName = label["repo"] as! String
                    
                    if repoName == repos{
                        var labelCoreDataInstance = self.labelCoreDataInstance.getLabel(nome, cor: color)
                        PullRequestManager.sharedInstance.addLabelToPullRequest(pullRequestCoreDataInstance, label: labelCoreDataInstance)
                    } else {
                        let newLabel = NSEntityDescription.insertNewObjectForEntityForName("Label", inManagedObjectContext: self.managedObjectContext!) as! Label
                        
                        newLabel.cor = color
                        newLabel.nome = nome
                        
                        self.managedObjectContext?.save(&error)
                        
                        PullRequestManager.sharedInstance.addLabelToPullRequest(pullRequestCoreDataInstance, label: newLabel)
                        
                    }
                }
                
            }
            
        }
        self.data.clearAll()
        
        self.userDefauls.setBool(self.switchDisplay.on, forKey: "\(User.sharedInstance.name)")
        
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

