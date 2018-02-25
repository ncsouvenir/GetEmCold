//
//  LoginVC.swift
//  TinyApp-GetEmCold!
//
//  Created by C4Q on 2/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController{
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginMessageLabel: UILabel!
    
    //var authService = AuthUserManager()
    private var isNewUser = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.delegate = self
        passwordTF.delegate = self
        AuthUserManager.manager.delegate = self
        loginMessageLabel.text = ""
        view.backgroundColor = UIColor.yellow
    }
    
    public static func storyboardInstance() -> LoginVC {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        return loginVC
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        guard let email = emailTF.text else { loginMessageLabel.text = "email is nil"; return }
        
        guard !email.isEmpty else { loginMessageLabel.text = "email is empty"; return }
        
        guard let password = passwordTF.text else { loginMessageLabel.text = "password is nil"; return }
        
        guard !password.isEmpty else { loginMessageLabel.text = "password is empty"; return }
        
        //Logging in user
        AuthUserManager.manager.login(withEmail: email, andPassword: password)
        print("\(email) signed in")
        print("\(AuthUserManager.manager.getCurrentUser()?.uid ?? "no current user")")
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        let createAccountVC = CreateAccountVC.storyboardInstance()
        present(createAccountVC, animated: true, completion: nil)
    }
    
    //    @IBAction func forgetPasswordPressed(_ sender: UIButton) {
    //        guard let email = emailTF.text else {return}
    //        AuthUserManager.manager.forgotPassword(withEmail: email)
    //        print("new password sent")
    //    }
}


extension LoginVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //    func textFieldDidBeginEditing(_ textField: UITextField) {
    //        emailTF.text = ""
    //        passwordTF.text = ""
    //    }
}


extension LoginVC: AuthUserDelegate {
    func didFailCreatingUser(_ userService: AuthUserManager, error: Error) {
        print("Can't create user")
    }
    
    func didCreateUser(_ userService: AuthUserManager, user: User) {
        //action already being handled in create account VC
    }
    
    func didFailToSignIn(_ userService: AuthUserManager, error: Error) {
        print("Can't sign in ")
    }
    
    func didSignIn(_ userService: AuthUserManager, user: User) {
        //show tab bar controller
        let tabController = TabBarController.storyboardInstance()
        present(tabController, animated: true, completion: nil)
        print("you are now at the tab bar controller")
    }
}


