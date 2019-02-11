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
    
}
