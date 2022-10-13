//
//  TaskDetailNavigator.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation

protocol ITaskDetailNavigator {
}

struct TaskDetailNavigator: ITaskDetailNavigator {
    weak var viewController: ITaskDetailViewController!
}
