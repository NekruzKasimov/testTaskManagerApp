//
//  AppNavigator.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
import Resolver
import RxCocoa

struct AppNavigator {

    let userRepository: IUserRepository
    let window: UIWindow

    func start() -> Signal<Void> {
        var vc: UIViewController = Resolver.resolve(ILoginViewController.self)

        if userRepository.getSignedUser() != nil {
            vc = Resolver.resolve(ITabbarViewController.self)
        }
        self.window.overrideUserInterfaceStyle = .light
        self.window.rootViewController = UINavigationController(rootViewController: vc)
        self.window.makeKeyAndVisible()
        return .never()
    }
}
