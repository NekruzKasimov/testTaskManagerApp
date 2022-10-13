//
//  NewTaskViewModel.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import RxSwift
import RxCocoa

protocol INewTaskViewModel {
    func transform(_ input: NewTaskViewModel.Input) -> NewTaskViewModel.Output
}

struct NewTaskViewModel: INewTaskViewModel {
    var navigator: INewTaskNavigator
    var taskRepository: ITaskRepository
    var userRepository: IUserRepository
    
    func transform(_ input: Input)  -> Output {
        
        var result = BehaviorRelay(value: false).asSignal(onErrorJustReturn: false)
        
        if let user = userRepository.getSignedUser() {
            let texts = Driver.combineLatest(input.titleText, input.message)
            
            result = input.acceptAction
                .withLatestFrom(texts)
                .filter({ title, message in
                    if title == "" {
                        navigator.showAlert()
                    }
                    return title != ""
                })
                .map { title, message in
                    let task = TaskModel()
                    task.title = title
                    task.message = message
                    task.creatorUserId = user.username
                    taskRepository.saveTask(task)
                    navigator.popBack()
                    return title != ""
                }
        }
        
        return Output(accepted: result)
    }
}

extension NewTaskViewModel {
    struct Input {
        let titleText: Driver<String>
        let message: Driver<String>
        let acceptAction: Signal<Void>
    }
    
    struct Output {
        let accepted: Signal<Bool>
    }
}

