//
//  ViewController.swift
//  FirebaseAuthPasswordIOS
//
//  Created by Eduardo Ribeiro da Silva on 08/07/19.
//  Copyright © 2019 Eduardo Ribeiro da Silva. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var loginSuccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigateToMainIfUserLogged()
    }
    
    private func navigateToMainIfUserLogged() {
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.navigateToMain()
                self.clearInputs()
            }
        }
    }
    
    private func navigateToMain() {
        self.performSegue(withIdentifier: "loginToMain", sender: nil)
    }
    
    private func clearInputs() {
        self.emailTextField.text = nil
        self.passwordTextField.text = nil
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "loginToMain" {
            guard
                let email = emailTextField.text,
                let password = passwordTextField.text,
                email.count > 0,
                password.count > 0
                else {
                    return false
            }
            
            Auth.auth().signIn(withEmail: email, password: password) { user, error in
                if let error = error, user == nil {
                    let alert = UIAlertController(title: "Sign In Failed",
                                                  message: error.localizedDescription,
                                                  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    self.loginSuccess = false
                } else {
                    // self.navigateToHome()
                    self.clearInputs()
                    
                    self.loginSuccess = true
                }
            }
            
            return loginSuccess
        }
        
        return true
    }
}

