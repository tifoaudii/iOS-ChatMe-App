//
//  MessageCell.swift
//  ChatMe
//
//  Created by Tifo Audi Alif Putra on 12/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userAvatar: RoundedUserImage!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(message: Message) {
        self.userAvatar.image = UIImage(named: message.userAvatar)
        self.userName.text = message.userName
        self.messageBody.text = message.message
        self.userAvatar.backgroundColor = UserService.instance.getAvatarBGColor(rgbComponent: message.userAvatarColor)
    }
}
