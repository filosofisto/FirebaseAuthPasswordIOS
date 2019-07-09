//
//  MainViewController.swift
//  FirebaseAuthPasswordIOS
//
//  Created by Eduardo Ribeiro da Silva on 08/07/19.
//  Copyright © 2019 Eduardo Ribeiro da Silva. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {

    var logoutSuccess = false
    
    @IBOutlet weak var labelWelcome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationConfig()
    }
    
    private func navigationConfig() {
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user == nil {
                self.navigateToLogin()
            } else {
                self.updateUIWithUser(user)
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "mainToLogin" {
            do {
                try Auth.auth().signOut()
                logoutSuccess = true
            } catch let signOutError as NSError {
                logoutSuccess = false
                print ("SignOut error: \(signOutError)")
            }
        }
        
        return logoutSuccess
    }
    
    private func navigateToLogin() {
        
    }
    
    private func updateUIWithUser(_ user: User?) {
        guard let email = user?.email else { return }
        labelWelcome.text = "Bem vindo \(email)"
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
