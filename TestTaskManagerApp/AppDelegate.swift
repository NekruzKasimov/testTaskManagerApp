//
//  AppDelegate.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import UIKit
import Resolver
import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let disposeBag = DisposeBag()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        setupAppNavigator()
        return true
    }
    
    func changeTabbarViewController() {
        setupAppNavigator()
    }
    
    private func setupAppNavigator() {
        Resolver
            .resolve(AppNavigator.self)
            .start()
            .emit()
            .disposed(by: self.disposeBag)

    }
}
