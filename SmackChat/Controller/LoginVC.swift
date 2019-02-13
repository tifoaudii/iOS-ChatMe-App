//
//  LoginVC.swift
//  SmackChat
//
//  Created by Tifo Audi Alif Putra on 25/01/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: RoundedButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }
    
    //close the login screen
    @IBAction func closeLogin(_ sender: Any) {
        self.errorMessage.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func register(_ sender: Any) {
        performSegue(withIdentifier: REGISTER_SEGUE, sender: nil)
    }
    
    @IBAction func login(_ sender: Any) {
       self.loginBtn.isLoading()
        self.errorMessage.isHidden = true
        
        guard let email = emailTextField.text, emailTextField.text != "" else { return }
        guard let password = passwordTextField.text, passwordTextField.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                self.getUserAccount()
            }else {
                self.errorMessage.isHidden = false
                self.loginBtn.loadingComplete(title: "Login")
            }
        }
    }
    
    private func getUserAccount() {
        AuthService.instance.findUserByEmail { (success) in
            NotificationCenter.default.post(name: USER_DATA_CHANGED, object: nil)
            self.onLoginSuccess()
        }
    }
    
    private func onLoginSuccess() {
        self.loginBtn.loadingComplete(title: "Login")
        dismiss(animated: true, completion: nil)
    }
    
    private func setupView(){
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.02641031146, green: 0.1492313743, blue: 0.3145045042, alpha: 1)])
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.02641031146, green: 0.1492313743, blue: 0.3145045042, alpha: 1)])
        errorMessage.isHidden = true
    }
}
