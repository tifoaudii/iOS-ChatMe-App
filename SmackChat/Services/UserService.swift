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
    
    func getAvatarBGColor(rgbComponent: String) -> UIColor {
        let rgbScanner = Scanner(string: rgbComponent)
        let skippedChar = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        rgbScanner.charactersToBeSkipped = skippedChar
        
        var R,G,B,A : NSString?
        rgbScanner.scanUpToCharacters(from: comma, into: &R)
        rgbScanner.scanUpToCharacters(from: comma, into: &G)
        rgbScanner.scanUpToCharacters(from: comma, into: &B)
        rgbScanner.scanUpToCharacters(from: comma, into: &A)
        
        let defaultColor = UIColor.lightGray
        guard let RValue = R else { return defaultColor }
        guard let GValue = G else { return defaultColor }
        guard let BValue = B else { return defaultColor }
        guard let AValue = A else { return defaultColor }
        
        let RFloat = CGFloat(RValue.doubleValue)
        let GFloat = CGFloat(GValue.doubleValue)
        let BFloat = CGFloat(BValue.doubleValue)
        let AFloat = CGFloat(AValue.doubleValue)
        
        let newColor = UIColor(red: RFloat, green: GFloat, blue: BFloat, alpha: AFloat)
        return newColor
    }
    
    func logoutUser() {
        id = ""
        name = ""
        email = ""
        avatarColor = ""
        avatarName = ""
        AuthService.instance.authToken = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        ChatService.instance.clearChannels()
        ChatService.instance.clearMessages()
    }
    
}
