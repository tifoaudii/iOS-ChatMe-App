//
//  RoundedButton.swift
//  SmackChat
//
//  Created by Tifo Audi Alif Putra on 29/01/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setupView()
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }

}
