//
//  TabbarNavigator.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
import Resolver

protocol ITabbarNavigator {
}

struct TabbarNavigator: ITabbarNavigator {
    weak var viewController: TabbarViewController!
}
