//
//  TabbarNavigator.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
import Resolver

protocol ITabbarNavigator {
    func openNewTaskPage()
}

struct TabbarNavigator: ITabbarNavigator {
    weak var viewController: TabbarViewController!
    
    func openNewTaskPage() {
        let vc = Resolver.resolve(INewTaskViewController.self)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
