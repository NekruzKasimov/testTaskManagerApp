//
//  LoginNavigator.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import UIKit
import Resolver

protocol ILoginNavigator {
    func wrongUserAlert()
    func fillUpFieldsAlert()
    func openSingUpPage()
    func signIn()
}

struct LoginNavigator: ILoginNavigator {
    weak var viewController: ILoginViewController!
    
    func wrongUserAlert() {
        showAlertController(with: R.string.localizable.loginWrongUsernameAlertMessage())
    }
    
    func fillUpFieldsAlert() {
        showAlertController(with: R.string.localizable.loginFillUpFieldsAlertMessage())
    }
    
    private func showAlertController(with message: String) {
        UIAlertController().show(with: message, from: viewController)
    }
    
    func openSingUpPage() {
        let vc = Resolver.resolve(ISignUpViewController.self)
        self.viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func signIn() {
        //
        // Restarting application
        //
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.changeTabbarViewController()
    }
}
