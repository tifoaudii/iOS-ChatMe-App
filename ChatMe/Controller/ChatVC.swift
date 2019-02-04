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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add target selector menuBtn
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        //add gesture recognization for drag menu and tap for close menu
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }
}
