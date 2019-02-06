//
//  AuthService.swift
//  SmackChat
//
//  Created by Tifo Audi Alif Putra on 28/01/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    //create singleton
    static let instance = AuthService()
    
    //create localstorage for keep the auth info
    var defaults = UserDefaults.standard
    
    //create the services
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGEDIN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGEDIN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: USER_TOKEN) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_TOKEN)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let body = [
            "email": email.lowercased(),
            "password": password
        ]
        
        //create a request
        Alamofire.request(REGISTER_URL, method: .post, parameters: body, encoding: JSONEncoding.default , headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let body = [
            "email": email.lowercased(),
            "password": password
        ]
        
        Alamofire.request(LOGIN_URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            do {
                let data = response.data
                let json = try JSON(data: data!)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                self.isLoggedIn = true
                
                
                completion(true)
            }catch let error as NSError {
                print(error)
            }
        }
    }
    
    func createUser(name: String, avatarName: String, avatarColor: String, email: String, completion: @escaping CompletionHandler) {
        
        let body = [
            "name": name,
            "avatarName": avatarName,
            "avatarColor": avatarColor,
            "email": email.lowercased()
        ]
        
        Alamofire.request(CREATE_USER_URL, method: .post , parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setupUserInfo(data: data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        
        Alamofire.request("\(FIND_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setupUserInfo(data: data)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    private func setupUserInfo(data: Data) {
        do {
            let json = try JSON(data: data)
            let id = json["_id"].stringValue
            let name = json["name"].stringValue
            let avatarName = json["avatarName"].stringValue
            let avatarColor = json["avatarColor"].stringValue
            let email = json["email"].stringValue
            
            UserService.instance.createUserData(id: id, avatarName: avatarName, avatarColor: avatarColor, email: email, name: name)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
}
