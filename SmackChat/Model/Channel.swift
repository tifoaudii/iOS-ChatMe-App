//
//  Channel.swift
//  ChatMe
//
//  Created by Tifo Audi Alif Putra on 08/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import Foundation
struct Channel {
    public private(set) var title: String!
    public private(set) var description: String!
    public private(set) var id: String!
    public private(set) var __v: Int?
    
    init(title: String, description: String, id: String ) {
        self.title = title
        self.description = description
        self.id = id
    }
}
