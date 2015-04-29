//
//  GitButton.swift
//  GitStatus
//
//  Created by Aleph Retamal on 4/28/15.
//  Copyright (c) 2015 Aleph Retamal. All rights reserved.
//

import UIKit

@IBDesignable

class GitButton: UIButton {
    
    var bgLayer: CAGradientLayer!
    let colorTop = UIColor(red: 138.0/255.0, green: 221.0/255.0, blue: 109.0/255.0, alpha: 1.0).CGColor
    let colorBottom = UIColor(red: 96.0/255.0, green: 176.0/255.0, blue: 68.0/255.0, alpha: 1.0).CGColor
    
    
    override func drawRect(rect: CGRect) {
        if bgLayer == nil {
            bgLayer = CAGradientLayer()
            
            bgLayer.frame = self.bounds
            bgLayer.colors = [colorTop, colorBottom]
            bgLayer.locations = [0.0, 1.0]
            bgLayer.borderColor = UIColor(red: 92.0/255.0, green: 169.0/255.0, blue: 65.0/255.0, alpha: 1.0).CGColor
            bgLayer.borderWidth = 1
            bgLayer.cornerRadius = 3
            
            self.layer.insertSublayer(bgLayer, atIndex: 0)
        }
    }

}
