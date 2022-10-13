//
//  RealmMigrator.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import RealmSwift
import Resolver

private struct ConstantValues {
    public static let schemaVersion: UInt64 = 3
}

extension Resolver {

    static func registerRealmMigrator() {
        register(IRealmMigrator.self) { RealmMigrator() }
    }
}

protocol IRealmMigrator {

    func getRealm() -> Realm
}

class RealmMigrator: IRealmMigrator {
    
    var db: Realm
    
    init() {
        let config = Realm.Configuration(schemaVersion: ConstantValues.schemaVersion,
                                         migrationBlock : { _, _ in
            
        })
        db = try! Realm(configuration: config)
        print(db.configuration.fileURL)
    }
    
    func getRealm() -> Realm {
        return db
    }
}

