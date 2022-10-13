//
//  UserModel.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import RealmSwift
import Realm

private struct ConstantValues {
    static let primaryKey = "username"
}

@objcMembers class UserModel: Object {
    dynamic var username: String = ""
    dynamic var password: String = ""
    dynamic var name: String = ""
    dynamic var lastName: String = ""
    
    override static func primaryKey() -> String {
        return ConstantValues.primaryKey
    }
}
