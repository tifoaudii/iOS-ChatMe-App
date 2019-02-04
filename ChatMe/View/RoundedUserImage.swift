//
//  RoundedUserImage.swift
//  SmackChat
//
//  Created by Tifo Audi Alif Putra on 31/01/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedUserImage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
    }
}
