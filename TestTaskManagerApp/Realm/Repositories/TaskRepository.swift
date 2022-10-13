//
//  TaskRepository.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import RealmSwift
import Resolver
import RxSwift


extension Resolver {

    static func registerTaskRepository() {
        register(ITaskRepository.self) { TaskRepository(realm: $0.resolve(IRealmMigrator.self).getRealm()) }
    }
}


protocol ITaskRepository {
    func getAllTasks() -> Observable<[TaskModel]>
    func saveTask(_ task: TaskModel)
}

private struct TaskRepository: ITaskRepository {
    
    let realm: Realm
    let taskRepository: Repository<TaskModel>
    
    init(realm: Realm) {
        self.realm = realm
        self.taskRepository = Repository(realm: self.realm)
    }
    
    func getAllTasks() -> Observable<[TaskModel]> {
        return taskRepository.getObjects()
    }
    
    func saveTask(_ task: TaskModel) {
        try? taskRepository.setSingleObject(task)
    }
}
