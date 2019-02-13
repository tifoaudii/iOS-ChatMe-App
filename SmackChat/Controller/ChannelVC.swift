//
//  ChannelVC.swift
//  SmackChat
//
//  Created by Tifo Audi Alif Putra on 24/01/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UIButton!
    @IBOutlet weak var channelTableView: UITableView!
    
    
    //create unwind segue
    @IBAction func unwindToChannelVC(segue: UIStoryboardSegue){}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.handleNotification), name: USER_DATA_CHANGED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.getChannels(_:)), name: CHANNELS_LOADED, object: nil)
        
        self.channelTableView.delegate = self
        self.channelTableView.dataSource = self
        
        SocketService.instance.getChannel { (success) in
            if success {
                self.channelTableView.reloadData()
            }
        }
        
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelID != ChatService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                ChatService.instance.unreadChannels.append(newMessage.channelID)
                self.channelTableView.reloadData()
            }
        }
    }
   
    override func viewDidAppear(_ animated: Bool) {
        self.checkCurrentUser()
        self.channelTableView.reloadData()
    }
    
    @objc func getChannels(_ notif:Notification ) {
        self.channelTableView.reloadData()
    }
    
    @objc func handleNotification(){
        self.checkCurrentUser()
    }
    
    private func checkCurrentUser() {
        if AuthService.instance.isLoggedIn {
            userName.setTitle(UserService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserService.instance.avatarName)
            userImage.backgroundColor = UserService.instance.getAvatarBGColor(rgbComponent: UserService.instance.avatarColor)
        }else {
            userName.setTitle("Login", for: .normal)
            userImage.image = UIImage(named: "profileDefault")
            userImage.backgroundColor = UIColor.lightGray
            channelTableView.reloadData()
        }
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profileModal = ProfileVC()
            profileModal.modalPresentationStyle = .custom
            present(profileModal, animated: true, completion: nil)
        }else {
            performSegue(withIdentifier: LOGIN_SEGUE, sender: nil)
        }
    }
    @IBAction func addChannel(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let addChannelModal = AddChannelVC()
            addChannelModal.modalPresentationStyle = .custom
            present(addChannelModal, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChatService.instance.channels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CHANNEL_CELL) as? ChannelCell {
            let channelName = ChatService.instance.channels[indexPath.row]
            cell.setupViewCell(channelName: channelName)
            return cell
        }else {
            return ChannelCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = ChatService.instance.channels[indexPath.row]
        ChatService.instance.selectedChannel = channel
        
        if ChatService.instance.unreadChannels.count > 0 {
            ChatService.instance.unreadChannels = ChatService.instance.unreadChannels.filter{ $0 != channel.id }
        }
        
        //reload cell
        let index = IndexPath(row: indexPath.row, section: 0)
        channelTableView.reloadRows(at: [index], with: .none)
        channelTableView.selectRow(at: index, animated: false, scrollPosition: .none)
        
        NotificationCenter.default.post(name: SELECTED_CHANNEL, object: nil)
        self.revealViewController()?.revealToggle(animated: true)
    }
}
