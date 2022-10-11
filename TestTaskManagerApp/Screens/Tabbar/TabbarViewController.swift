//
//  TabbarViewController.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import UIKit
import SnapKit
import Resolver
import RxCocoa
import RxSwift
import Resolver

protocol ITabbarScreen: AnyObject {
    var viewModel: ITabbarViewModel! { set get }
}

typealias ITabbarViewController = UITabBarController & ITabbarScreen

final class TabbarViewController: ITabbarViewController {
    var viewModel: ITabbarViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white
        setupControllers()
    }
    
    func setupControllers() {
        let mainScreen = Resolver.resolve(IMainPageViewController.self)
        let profileScreen = Resolver.resolve(IProfileViewController.self)
        let icon1 = UITabBarItem(title: R.string.localizable.tabbarMainViewControllerTitle(), image: R.image.home(), selectedImage: R.image.home())
        let icon2 = UITabBarItem(title: R.string.localizable.tabbarProfileViewControllerTitle(), image: R.image.profile(), selectedImage: R.image.profile())
        mainScreen.tabBarItem = icon1
        profileScreen.tabBarItem = icon2
        let controllers: [BaseViewController] = [mainScreen, profileScreen]
        self.viewControllers = controllers
    }
}
