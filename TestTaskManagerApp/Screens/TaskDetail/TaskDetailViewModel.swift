//
//  TaskDetailViewModel.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import RxSwift
import RxCocoa

protocol ITaskDetailViewModel {
    func transform(_ input: TaskDetailViewModel.Input) -> TaskDetailViewModel.Output
}

struct TaskDetailViewModel: ITaskDetailViewModel {
    var navigator: ITaskDetailNavigator
    var taskRepository: ITaskRepository
    var userRepository: IUserRepository
    var task: TaskModel
    
    func transform(_ input: Input) -> Output {
        
        let result = input.viewWillAppear.flatMap { Signal.just(task) }
        
        return Output(task: result)
    }
    
}

extension TaskDetailViewModel {
    struct Input {
        var viewWillAppear: Signal<Void>
    }
    
    struct Output {
        var task: Signal<TaskModel>
    }
}
