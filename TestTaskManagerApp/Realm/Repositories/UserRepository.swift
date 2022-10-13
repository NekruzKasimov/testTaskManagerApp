//
//  UserRepository.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import RealmSwift
import Resolver
import RxSwift


extension Resolver {

    static func registerUserRepository() {
        register(IUserRepository.self) { UserRepository(realm: $0.resolve(IRealmMigrator.self).getRealm()) }
    }
}

private struct ConstantValues {
    static let signedUser = "SignedInUser"
}

protocol IUserRepository {
    func signInUser(_ user: UserModel)
    func signOutUser()
    func getSignedUser() -> UserModel?
    func getUser(by username: String) -> UserModel?
    func saveUser(_ user: UserModel)
    func getAllUsers() -> [UserModel]
}

private struct UserRepository: IUserRepository {

    let realm: Realm
    let defaults = UserDefaults.standard
    let userRepository: Repository<UserModel>

    init(realm: Realm) {
        self.realm = realm
        userRepository = Repository(realm: self.realm)
    }
    
    func getUser(by username: String) -> Observable<UserModel?> {
        return userRepository.object(for: UserModel.primaryKey())
    }
    
    func getUser(by username: String) -> UserModel? {
        return userRepository.object(for: username)
    }
    
    func saveUser(_ user: UserModel) {
        try? userRepository.setSingleObject(user)
        self.signInUser(user)
    }
    
    func getAllUsers() -> [UserModel] {
        return userRepository.getObjects().toArray()
    }
    
    func signInUser(_ user: UserModel) {
        defaults.set(user.username, forKey: ConstantValues.signedUser)
    }
    
    func signOutUser() {
        defaults.removeObject(forKey: ConstantValues.signedUser)
    }
    
    func getSignedUser() -> UserModel? {
        guard let userId = defaults.string(forKey: ConstantValues.signedUser) else { return nil }
        return self.getUser(by: userId)
    }
}
