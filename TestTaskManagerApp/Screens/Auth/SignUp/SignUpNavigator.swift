//
//  SignUpNavigator.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import UIKit

protocol ISignUpNavigator {
    func signUp()
    func fillUpFieldsAlert()
}

struct SignUpNavigator: ISignUpNavigator {
    weak var viewController: ISignUpViewController!
    
    func fillUpFieldsAlert() {
        UIAlertController().show(with: R.string.localizable.loginFillUpFieldsAlertMessage(), from: viewController)
    }
    
    func signUp() {
        //
        // Restarting application
        //
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.changeTabbarViewController()
    }
}
