//
//  TaskModel.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import RealmSwift
import Realm
import RxSwift

enum TaskStatus: String {
    case created = "created"
    case InProgress = "inProgress"
    case onReview = "onReview"
    case closed = "closed"
}

@objcMembers class TaskModel: Object {
    dynamic var id: String = UUID().uuidString
    dynamic var title: String = ""
    dynamic var message: String = ""
    dynamic var creatorUserId: String = ""
    
    var status: TaskStatus = TaskStatus.created {
        didSet {
            statusString = status.rawValue
        }
    }
    
    private dynamic var statusString: String = ""
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    override init() {
        super.init()
        status = TaskStatus(rawValue: statusString) ?? .created
    }
}
