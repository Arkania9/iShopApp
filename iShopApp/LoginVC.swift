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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
                print("KAMIL: SUCCESFULLY authethicated with Firebase")
            }
        })
    }
    
    @IBAction func fbLoginPressed(_ sender: AnyObject) {
        startFbLogin()
    }
    

}

