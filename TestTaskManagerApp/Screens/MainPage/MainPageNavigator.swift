//
//  MainPageNavigator.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
import Resolver

protocol IMainPageNavigator {
}

struct MainPageNavigator: IMainPageNavigator {
    weak var viewController: IMainPageViewController!
    
}
