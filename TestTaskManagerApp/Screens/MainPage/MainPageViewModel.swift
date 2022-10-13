//
//  MainPageViewModel.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt

protocol IMainPageViewModel {
    func transform(_ input: MainPageViewModel.Input) -> MainPageViewModel.Output
}

struct MainPageViewModel: IMainPageViewModel {
    var navigator: IMainPageNavigator
    var taskRepository: ITaskRepository
    
    func transform(_ input: Input) -> Output {
        let objects = input
            .viewWillAppear
            .flatMapLatest { _ in
                taskRepository
                    .getAllTasks()
                    .asSignal(onErrorJustReturn: [])
            }
        
        let result = objects
            .also { objects in
                input.itemSelected.flatMapLatest { indexPath -> Signal<Void> in
                    navigator.openDetailTaskPage(with: objects[indexPath.item])
                    return .never()
                }
            }.asSignal(onErrorJustReturn: [])
            
        return Output(result: result)
    }
    
}

extension MainPageViewModel {
    struct Input {
        var viewWillAppear: Signal<Void>
        var itemSelected: Signal<IndexPath>
    }
    
    struct Output {
        var result: Signal<[TaskModel]>
    }
}
