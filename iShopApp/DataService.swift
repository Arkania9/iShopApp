//
//  DataService.swift
//  iShopApp
//
//  Created by Kamil Zajac on 15.03.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _REF_WOMEN_DB = DB_BASE.child("WomenItems")
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_WOMEN_ST = STORAGE_BASE.child("Items-pics")
    
    var REF_WOMEN_DB: FIRDatabaseReference {
        return _REF_WOMEN_DB
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT: FIRDatabaseReference {
        let uid = UserDefaults.standard.object(forKey: "UserID")
        let user = REF_USERS.child(uid! as! String)
        return user
    }
    
    var REF_WOMEN_ST: FIRStorageReference {
        return _REF_WOMEN_ST
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
}
