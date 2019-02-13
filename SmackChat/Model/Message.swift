//
//  Message.swift
//  ChatMe
//
//  Created by Tifo Audi Alif Putra on 11/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import Foundation

struct Message {
    public private(set) var message: String!
    public private(set) var userName: String!
    public private(set) var channelID: String!
    public private(set) var userAvatar: String!
    public private(set) var userAvatarColor: String!
    public private(set) var id: String!
    public private(set) var timeStamp: String!
    
    init(message: String, userName: String, channelID: String, userAvatar: String, userAvatarColor: String, id: String, timeStamp: String) {
        self.message = message
        self.userName = userName
        self.channelID = channelID
        self.userAvatar = userAvatar
        self.userAvatarColor = userAvatarColor
        self.id = id
        self.timeStamp = timeStamp
    }
}
