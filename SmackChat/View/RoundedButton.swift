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
    
    var spinner: UIActivityIndicatorView!
    
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
    
    func loadingComplete(title: String) {
        self.setTitle(title, for: .normal)
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    
    func isLoading(){
        if spinner == nil {
            spinner = UIActivityIndicatorView()
        }
        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle("", for: .normal)
        self.addSubview(spinner)
        centerActivityIndicatorInButton()
        spinner.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: spinner, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: spinner, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }

}
