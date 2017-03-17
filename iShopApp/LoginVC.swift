//
//  ViewController.swift
//  iShopApp
//
//  Created by Kamil Zajac on 12.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit

class LoginVC: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pwdField: UITextField!

    @IBOutlet weak var errorField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = 300
        self.revealViewController().frontViewShadowRadius = 2
        self.revealViewController().frontViewShadowOpacity = 0.6
        self.revealViewController().rearViewRevealOverdraw = 0
    }
    
    func startFbLogin() {
        let fbManager = FBSDKLoginManager()
        fbManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("KAMIL: ERROR with facebook login")
            } else if result?.isCancelled == true {
                print("KAMI: USER canceled facebook login")
            } else {
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.fbAuthInFirebase(credential)
            }
        }
    }
    
    func fbAuthInFirebase(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("KAMIL: UNABLE to authethicate with Firebase")
            } else {
                if let user = user {
                    let userData = ["provider":credential.provider]
                    self.sendCurrentUserInfoToFirebase(id: user.uid, userData: userData)
                }
            }
        })
    }
    
    func signInToFirebase(email: String, pwd: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
            if error != nil {
                _ = FIRAuthErrorCode.errorCodeInvalidEmail
            self.errorField.text = "Email or Password are wrong"
            } else {
                if let user = user {
                    let userData = ["provider":user.providerID]
                    self.sendCurrentUserInfoToFirebase(id: user.uid, userData: userData)
                }
            }
        })
    }
    
    func sendCurrentUserInfoToFirebase(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        performSegue(withIdentifier: "showMainVC", sender: nil)
    }
    
    @IBAction func fbLoginPressed(_ sender: AnyObject) {
        startFbLogin()
    }
    
    @IBAction func firebaseLoginPressed(_ sender: AnyObject) {
        guard let email = emailField.text, email != "" else {
            self.errorField.text = "Email field can't be empty"
            return
        }
        guard let pwd = pwdField.text, pwd != "" else {
            self.errorField.text = "Password field can't be empty"
            return
        }
        signInToFirebase(email: email, pwd: pwd)
    }

}

