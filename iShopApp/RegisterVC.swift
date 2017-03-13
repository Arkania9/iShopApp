//
//  RegisterVC.swift
//  iShopApp
//
//  Created by Kamil Zajac on 13.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var errorField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func signUpToFirebase(email: String, pwd: String) {
        FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
            if error == nil {
                self.errorField.text = "Account was created, back to login"
                self.emailField.text = ""
                self.pwdField.text = ""
            } else {
                _ = FIRAuthErrorCode.errorCodeEmailAlreadyInUse
                self.errorField.text = "Email already in use"
            }
        })
    }
    
    @IBAction func registerBtnPressed(_ sender: AnyObject) {
        guard let email = emailField.text, email != "" else {
            self.errorField.text = "Email field can't be empty"
            return
        }
        guard let pwd = pwdField.text, pwd != "" else {
            self.errorField.text = "Password field can't be empty"
            return
        }
        signUpToFirebase(email: email, pwd: pwd)
    }

    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
