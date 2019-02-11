//
//  AddChannelVC.swift
//  ChatMe
//
//  Created by Tifo Audi Alif Putra on 08/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var backgroundUI: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }
    
    private func setupView(){
        titleTextField.attributedPlaceholder = NSAttributedString(string: "title", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.02641031146, green: 0.1492313743, blue: 0.3145045042, alpha: 1)])
        descTextField.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.02641031146, green: 0.1492313743, blue: 0.3145045042, alpha: 1)])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.handleTap))
        backgroundUI.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannel(_ sender: Any) {
        guard let title = titleTextField.text, titleTextField.text != "" else { return }
        guard let description = descTextField.text, descTextField.text != "" else { return }
        
        SocketService.instance.addChannel(title: title, description: description) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
