//
//  UserService.swift
//  SmackChat
//
//  Created by Tifo Audi Alif Putra on 29/01/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import Foundation
class UserService {
    
    static let instance = UserService()
    var id: String = ""
    var avatarName: String = ""
    var avatarColor: String = ""
    var email: String = ""
    var name: String = ""
    
    func createUserData(id: String, avatarName: String, avatarColor: String, email: String, name: String){
        self.id = id
        self.avatarName = avatarName
        self.avatarColor = avatarColor
        self.email = email
        self.name = name
    }
    
    func updateAvatar(name: String) {
        self.avatarName = name
    }
    
}
