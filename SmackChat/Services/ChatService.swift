//
//  ChatService.swift
//  ChatMe
//
//  Created by Tifo Audi Alif Putra on 08/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ChatService {
    
    static let instance = ChatService()
    var channels = [Channel]()
    var selectedChannel: Channel?
    
    func fetchAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(FETCH_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            guard let data = response.data else { return }
            do {
                if let json = try JSON(data: data).array {
                    
                    for item in json {
                        let name = item["name"].stringValue
                        let description = item["description"].stringValue
                        let id = item["_id"].stringValue
                        
                        let channel = Channel(title: name, description: description, id: id)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: CHANNELS_LOADED, object: nil)
                    completion(true)
                }
            } catch let error as NSError {
                completion(false)
                debugPrint(error)
            }
        }
    }
    
    func clearChannels() {
        self.channels.removeAll()
    }
}
