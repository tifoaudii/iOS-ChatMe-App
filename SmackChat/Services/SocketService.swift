//
//  SocketService.swift
//  ChatMe
//
//  Created by Tifo Audi Alif Putra on 09/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    static let instance = SocketService()
    let manager: SocketManager
    let socket: SocketIOClient
    
    override init() {
        self.manager = SocketManager(socketURL: URL(string: BASE_URL)!)
        self.socket = manager.defaultSocket
        super.init()
    }
    
    func establishConnection() {
        self.socket.connect()
    }
    
    func closeConnection() {
        self.socket.disconnect()
    }
    
    func addChannel(title: String, description: String, completion: @escaping CompletionHandler) {
        self.socket.emit("newChannel", title, description)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let title = dataArray[0] as? String else { return }
            guard let description = dataArray[1] as? String else { return }
            guard let channelID = dataArray[2] as? String else { return }
            
            let newChannel = Channel(title: title, description: description, id: channelID)
            ChatService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addNewMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getChatMessage(completion: @escaping (_ newMessage: Message) -> Void) {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String else { return }
            guard let channelID = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timestamp = dataArray[7] as? String else { return }
            
            let newMessage = Message(message: messageBody, userName: userName, channelID: channelID, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timestamp)
            completion(newMessage)
        }
    }
    
    func listenUserTyping(_ completion: @escaping (_ typingUser: [String:String]) -> Void) {
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUser = dataArray[0] as? [String:String] else { return }
            completion(typingUser)
        }
    }
}
