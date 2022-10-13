//
//  Realm+Extension.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import RealmSwift

extension Realm {

    func writeOpeningTransactionIfNeeded(_ block: (() throws -> Void)) throws {
        if self.isInWriteTransaction {
            try block()
        } else {
            try self.write(block)
        }
    }
}
