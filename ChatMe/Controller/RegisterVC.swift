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
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var registerButton: RoundedButton!
    
    //variable
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserService.instance.avatarName != "" {
            userImage.image = UIImage(named: UserService.instance.avatarName)
            avatarName = UserService.instance.avatarName
        }
    }
    
    @IBAction func closeRegister(_ sender: Any) {
        self.performSegue(withIdentifier: UNWIND_CHANNELVC, sender: nil)
    }
    
    @IBAction func pickAvatar(_ sender: Any) {
        self.performSegue(withIdentifier: AVATAR_PICKER_SEGUE, sender: nil)
    }
    
    @IBAction func pickBGColor(_ sender: Any) {
        let R = CGFloat(arc4random_uniform(255)) / 255
        let G = CGFloat(arc4random_uniform(255)) / 255
        let B = CGFloat(arc4random_uniform(255)) / 255
        
        let bgColor = UIColor(red: R, green: G, blue: B, alpha: 1)
        UIView.animate(withDuration: 0.3) {
            self.userImage.backgroundColor = bgColor
        }
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        guard let name = usernameTextField.text, usernameTextField.text != "" else { return }
        guard let email = emailTextField.text, emailTextField.text != "" else { return }
        guard let password = passwordTextField.text, passwordTextField.text != "" else { return }
        
        registerButton.isLoading()
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                self.onHandleRegister(email: email, password: password, name: name)
            }
        }
    }
    
    private func onHandleRegister(email: String, password: String, name: String) {
        AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
            if success {
                self.onCreateUser(name: name, email: email)
            }
        })
    }
    
    private func onCreateUser(name: String, email: String){
        AuthService.instance.createUser(name: name, avatarName: self.avatarName, avatarColor: self.avatarColor, email: email, completion: { (success) in
            
            if success {
                NotificationCenter.default.post(name: USER_DATA_CHANGED, object: nil)
                self.registerButton.loadingComplete(title: "Register")
                self.performSegue(withIdentifier: UNWIND_CHANNELVC, sender: nil)
            }
        })
    }
    
    private func setupCustomView(){
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)])
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
}
