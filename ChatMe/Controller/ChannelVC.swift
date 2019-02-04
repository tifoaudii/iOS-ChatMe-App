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
    
    @objc func handleNotification(){
        if AuthService.instance.isLoggedIn {
            
        }
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        performSegue(withIdentifier: LOGIN_SEGUE, sender: nil)
    }
    
}
