//
//  ChatVC.swift
//  SmackChat
//
//  Created by Tifo Audi Alif Putra on 24/01/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var chanelName: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var sendMessageBtn: UIButton!
    @IBOutlet weak var userTypingLabel: UILabel!
    
    var isTyping: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        //add target selector menuBtn
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.estimatedRowHeight = 80
        chatTableView.rowHeight = UITableView.automaticDimension
        
        self.scrollToLastChat()
        self.sendMessageBtn.isHidden = true
        
        //add gesture recognization for drag menu and tap for close menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.setupUserChannels(_:)), name: USER_DATA_CHANGED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.handleSelectedChannel(_:)), name: SELECTED_CHANNEL, object: nil)
        
        SocketService.instance.getChatMessage { (newMessage) in
            ChatService.instance.messages.append(newMessage)
            self.chatTableView.reloadData()
            self.scrollToLastChat()
        }
        
        SocketService.instance.listenUserTyping { (typingUser) in
            guard let channelID = ChatService.instance.selectedChannel?.id else { return }
            var names = ""
            var numberOfTyper = 0
            
            for(typingUser, channel) in typingUser {
                if typingUser != UserService.instance.name && channel == channelID {
                    
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTyper += 1
                }
            }
            
            if  numberOfTyper > 0 && AuthService.instance.isLoggedIn {
                var verb = "is"
                if numberOfTyper > 1 {
                    verb = "are"
                }
                self.userTypingLabel.text = "\(names) \(verb) typing a message"
            }
        }
        
        //check current user
        AuthService.instance.findUserByEmail { (success) in
            NotificationCenter.default.post(name: USER_DATA_CHANGED, object: nil)
        }
    }
    
    private func scrollToLastChat() {
        if ChatService.instance.messages.count > 0 {
            let endIndex = IndexPath(row: ChatService.instance.messages.count - 1, section: 0)
            chatTableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
        }
    }
    
    private func setupView() {
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
    
    @objc private func setupUserChannels(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            //retrieve channels
            self.onSetMessage()
        } else {
           chanelName.text = "ChatMe"
            chatTableView.reloadData()
        }
    }
    
    @objc private func handleSelectedChannel(_ notif: Notification) {
        updateChannel()
    }
    
    func updateChannel() {
        let selectedChannel = ChatService.instance.selectedChannel?.title ?? ""
        self.chanelName.text = "#\(selectedChannel)"
        self.getMessages()
    }
    
    @IBAction func sendNewMessage(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = ChatService.instance.selectedChannel?.id else { return }
            guard let message = messageTextField.text, messageTextField.text != "" else { return }
            
            SocketService.instance.addNewMessage(messageBody: message, userId: UserService.instance.id, channelId: channelId) { (success) in
                if success {
                    self.messageTextField.text = ""
                    self.messageTextField.resignFirstResponder()
                }
            }
        }
    }
    
    @IBAction func onTypingMessage(_ sender: Any) {
        guard let channelID = ChatService.instance.selectedChannel?.id else { return }
        let user = UserService.instance.name
        if messageTextField.text == "" {
            self.isTyping = false
            sendMessageBtn.isHidden = true
            SocketService.instance.socket.emit("stopTyping", user, channelID)
        } else {
            self.isTyping = true
            sendMessageBtn.isHidden = false
            SocketService.instance.socket.emit("StartTyping", user, channelID)
        }
    }
    
    private func onSetMessage () {
        ChatService.instance.fetchAllChannel { (success) in
            if success {
                if ChatService.instance.channels.count > 0 {
                    ChatService.instance.selectedChannel = ChatService.instance.channels[0]
                    self.updateChannel()
                } else {
                    self.chanelName.text = "ChatMe"
                }
            }
        }
    }
    
    private func getMessages() {
        guard let selectedChannel = ChatService.instance.selectedChannel else { return }
        ChatService.instance.getAllMessage(channelID: selectedChannel.id) { (success) in
            if success {
                self.chatTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChatService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MESSAGE_CELL) as? MessageCell {
            let message = ChatService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        }else {
            return MessageCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
