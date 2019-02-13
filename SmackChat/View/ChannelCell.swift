//
//  ChannelCell.swift
//  ChatMe
//
//  Created by Tifo Audi Alif Putra on 08/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func setupViewCell(channelName: Channel) {
        self.channelName.text = "#\(channelName.title ?? "")"
        self.channelName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        for id in ChatService.instance.unreadChannels {
            if id == channelName.id {
                self.channelName.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
            }
        }
    }
}
