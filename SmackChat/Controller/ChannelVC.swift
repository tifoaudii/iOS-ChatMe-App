//
//  ChannelVC.swift
//  SmackChat
//
//  Created by Tifo Audi Alif Putra on 24/01/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    //create unwind segue
    @IBAction func unwindToChannelVC(segue: UIStoryboardSegue){}

    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController()?.rearViewRevealWidth = self.view.frame.width - 60
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        performSegue(withIdentifier: LOGIN_SEGUE, sender: nil)
    }
    
}
