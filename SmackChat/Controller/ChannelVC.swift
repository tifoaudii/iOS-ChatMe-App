//
//  ChannelVC.swift
//  SmackChat
//
//  Created by Tifo Audi Alif Putra on 24/01/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UIButton!
    
    
    //create unwind segue
    @IBAction func unwindToChannelVC(segue: UIStoryboardSegue){}

    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.handleNotification), name: USER_DATA_CHANGED, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.checkCurrentUser()
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
    
}
