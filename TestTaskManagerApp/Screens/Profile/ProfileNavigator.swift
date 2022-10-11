//
//  ProfileNavigator.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
protocol IProfileNavigator {
}

struct ProfileNavigator: IProfileNavigator {
    weak var viewController: IProfileViewController!
}
