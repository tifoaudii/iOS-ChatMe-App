//
//  ChatVC.swift
//  SmackChat
//
//  Created by Tifo Audi Alif Putra on 24/01/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var chanelName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add target selector menuBtn
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        //add gesture recognization for drag menu and tap for close menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.setupUserChannels(_:)), name: USER_DATA_CHANGED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.handleSelectedChannel(_:)), name: SELECTED_CHANNEL, object: nil)
        
        //check current user
        AuthService.instance.findUserByEmail { (success) in
            NotificationCenter.default.post(name: USER_DATA_CHANGED, object: nil)
        }
    }
    
    @objc private func setupUserChannels(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            //retrieve channels
            self.onSetMessage()
        } else {
           chanelName.text = "ChatMe"
        }
    }
    
    @objc private func handleSelectedChannel(_ notif: Notification) {
        chanelName.text = ChatService.instance.selectedChannel?.title
    }
    
    private func onSetMessage () {
        ChatService.instance.fetchAllChannel { (success) in
            if success {
                
            }
        }
    }
}
