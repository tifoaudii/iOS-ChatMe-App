//
//  Constant.swift
//  SmackChat
//
//  Created by Tifo Audi Alif Putra on 25/01/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import Foundation


//completion handler for asynchronuse web request
typealias CompletionHandler = (_ Success: Bool) -> ()

//URL Endpoint
let BASE_URL = "https://smackchat-server.herokuapp.com/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"
let CREATE_USER_URL = "\(BASE_URL)user/add"

//seques
let LOGIN_SEGUE = "login_segue"
let REGISTER_SEGUE = "register_segue"
let UNWIND_CHANNELVC = "unwind_channelvc"

//Auth Services
let USER_TOKEN = "user_token"
let USER_EMAIL = "user_email"
let LOGGEDIN_KEY = "loggedIn_key"

//Header Request
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]
