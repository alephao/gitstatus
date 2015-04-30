//
//  GitButton2.swift
//  GitStatus
//
//  Created by Aleph Retamal on 4/30/15.
//  Copyright (c) 2015 Guilherme Ferreira de Souza. All rights reserved.
//

import UIKit

@IBDesignable

class GitButton2: UIButton {
    
    var bgLayer: CAGradientLayer!
    let colorTop = UIColor(hex: "fcfcfc").CGColor
    let colorBottom = UIColor(hex: "eeeeee").CGColor
    
    
    override func drawRect(rect: CGRect) {
        if bgLayer == nil {
            bgLayer = CAGradientLayer()
            
            bgLayer.frame = self.bounds
            bgLayer.colors = [colorTop, colorBottom]
            bgLayer.locations = [0.0, 1.0]
            bgLayer.borderColor = UIColor(hex: "d5d5d5").CGColor
            bgLayer.borderWidth = 1
            bgLayer.cornerRadius = 3
            
            self.layer.insertSublayer(bgLayer, atIndex: 0)
        }
    }
    
}