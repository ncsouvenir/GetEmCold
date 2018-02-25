//
//  CreateAccountVC.swift
//  TinyApp-GetEmCold!
//
//  Created by C4Q on 2/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
        //AuthUserManager.manager.delegate = self
        emailTF.delegate = self
        userNameTF.delegate = self
        passwordTF.delegate = self
    }
    
    public static func storyboardInstance() -> CreateAccountVC {
        let storyboard = UIStoryboard(name: "CreateAccount", bundle: nil)
        let createAccountVC = storyboard.instantiateViewController(withIdentifier: "CreateAccountVC") as! CreateAccountVC
        return createAccountVC
    }
    
    
    @IBAction func createAccountButton(_ sender: UIButton) {
        guard let email = emailTF.text else { return }

        guard !email.isEmpty else { return }

        guard let password = passwordTF.text else { return }

        guard !password.isEmpty else {return }

        guard let userName = userNameTF.text else {  return }

        guard !userName.isEmpty else { return }
        AuthUserManager.manager.createAccount(withEmail: email, password: password, AndUserName: userName)
        print("account created! Check your email: \(email)")
        dismiss(animated: true, completion: nil)
    }
}

extension CreateAccountVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
