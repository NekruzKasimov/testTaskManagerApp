//
//  ProfileNavigator.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
import UIKit

protocol IProfileNavigator {
    func restartApplication()
}

struct ProfileNavigator: IProfileNavigator {
    weak var viewController: IProfileViewController!
    
    func restartApplication() {
        //
        // Restarting application
        //
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.changeTabbarViewController()
    }
}
