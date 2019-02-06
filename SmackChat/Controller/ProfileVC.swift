//
//  ProfileVC.swift
//  ChatMe
//
//  Created by Tifo Audi Alif Putra on 04/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var backgroundUI: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView(){
        userAvatar.image = UIImage(named: UserService.instance.avatarName)
        userName.text = UserService.instance.name
        userEmail.text = UserService.instance.email
        userAvatar.backgroundColor = UserService.instance.getAvatarBGColor(rgbComponent: UserService.instance.avatarColor)
        
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.handleCloseTap))
        backgroundUI.addGestureRecognizer(closeTap)
    }
    
    @objc func handleCloseTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        UserService.instance.logoutUser()
        NotificationCenter.default.post(name: USER_DATA_CHANGED, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
}
