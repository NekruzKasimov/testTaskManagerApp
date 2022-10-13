//
//  NewTaskNavigator.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import UIKit

protocol INewTaskNavigator {
    func popBack()
    func showAlert()
}

struct NewTaskNavigator: INewTaskNavigator {
    weak var viewController: INewTaskViewController!
    
    func popBack() {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func showAlert() {
        UIAlertController().show(with: R.string.localizable.newTaskTitleFieldWarningMessage(), from: viewController)
    }
}
