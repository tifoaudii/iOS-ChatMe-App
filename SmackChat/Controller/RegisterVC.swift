//
//  RegisterVC.swift
//  SmackChat
//
//  Created by Tifo Audi Alif Putra on 26/01/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    //outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //variable
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closeRegister(_ sender: Any) {
        self.performSegue(withIdentifier: UNWIND_CHANNELVC, sender: nil)
    }
    
    @IBAction func pickAvatar(_ sender: Any) {
    }
    
    @IBAction func pickBGColor(_ sender: Any) {
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        guard let name = usernameTextField.text, usernameTextField.text != "" else { return }
        guard let email = emailTextField.text, emailTextField.text != "" else { return }
        guard let password = passwordTextField.text, passwordTextField.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, avatarName: self.avatarName, avatarColor: self.avatarColor, email: email, completion: { (success) in
                            
                            if success {
                                self.performSegue(withIdentifier: UNWIND_CHANNELVC, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
}
