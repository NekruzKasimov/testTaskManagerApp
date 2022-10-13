//
//  MainPageNavigator.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
import Resolver

protocol IMainPageNavigator {
    func openDetailTaskPage(with task: TaskModel)
}

struct MainPageNavigator: IMainPageNavigator {
    weak var viewController: IMainPageViewController!
    
    func openDetailTaskPage(with task: TaskModel) {
        let vc = Resolver.resolve(
            ITaskDetailViewController.self,
            args: ["task": task]
        )
        viewController.navigationController?.show(vc, sender: self)
    }
}
