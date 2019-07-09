//
//  CreateUserViewController.swift
//  FirebaseAuthPasswordIOS
//
//  Created by Eduardo Ribeiro da Silva on 08/07/19.
//  Copyright © 2019 Eduardo Ribeiro da Silva. All rights reserved.
//

import UIKit
import Firebase

class CreateUserViewController: UIViewController {

    var userCreationSuccess = false

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "createUserToMain" {
            guard
                let email = emailTextField.text,
                let password = passwordTextField.text,
                email.count > 0,
                password.count > 0
                else {
                    return false
            }
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error, let user = authResult?.user {
                    let alert = UIAlertController(title: "Sign Up Failed",
                                                  message: error.localizedDescription,
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                    
                    self.userCreationSuccess = false
                } else {
                    self.clearInputs()
                    
                    self.userCreationSuccess = true
                }
            }
        }
        
        return true
    }
        
    private func clearInputs() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
