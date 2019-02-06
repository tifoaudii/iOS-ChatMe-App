//
//  AvatarCell.swift
//  SmackChat
//
//  Created by Tifo Audi Alif Putra on 30/01/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    func setupAvatarCell(index: Int,type: AvatarType){
        if type == AvatarType.dark {
            self.layer.backgroundColor = UIColor.gray.cgColor
            avatarImage.image = UIImage(named: "dark\(index)")
        } else {
            self.layer.backgroundColor = UIColor.lightGray.cgColor
            avatarImage.image = UIImage(named: "light\(index)")
        }
    }
    
    private func setupView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
    }
}
