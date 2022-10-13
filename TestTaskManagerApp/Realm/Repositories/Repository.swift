//
//  Repository.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import RealmSwift
import RxCocoa
import RxRealm
import RxSwift

struct Repository<O: Object> {

    let realm: Realm

    func setSingleObject(_ object: O?) throws {
        try self.realm.writeOpeningTransactionIfNeeded {
            if let object = object {
                self.realm.add(object, update: .all)
            }
        }
    }

    func getObjects() -> Observable<[O]> {
        return Observable.array(from: self.realm.objects(O.self))
    }

    func getObjects(_ sorter: (keypath: String, ascending: Bool)? = nil, predicate: NSPredicate? = nil) -> Results<O> {
        var objects = self.realm.objects(O.self)
        if let sorter = sorter {
            objects = objects.sorted(byKeyPath: sorter.keypath, ascending: sorter.ascending)
        }
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        return objects
    }

    func object<KeyType>(for primaryKey: KeyType) -> Observable<O?> {
        return Observable
            .collection(from: self.realm.objects(O.self).filter("%K == %@", O.primaryKey()!, primaryKey))
            .flatMapLatest { results -> Observable<O?> in
                if !results.isEmpty {
                    return Observable.from(object: results.first!).map { $0 as O? }
                } else {
                    return .just(nil)
                }
            }
    }
    
    func object<KeyType>(for primaryKey: KeyType) -> O? {
        return self.realm.object(ofType: O.self, forPrimaryKey: primaryKey)
    }
}
