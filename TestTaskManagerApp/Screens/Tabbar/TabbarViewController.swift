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
    var viewModel: ITabbarViewModel! { get set }
}

typealias ITabbarViewController = UITabBarController & ITabbarScreen

class TabbarViewController: ITabbarViewController {
    var viewModel: ITabbarViewModel! {
        didSet {
            bind()
        }
    }
    
    private var rightBarButton = UIBarButtonItem()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white
        rightBarButton = UIBarButtonItem(title: R.string.localizable.tabBarAddTaskTitle(), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightBarButton
        setControllers()
    }
    
    func bind() {
        let input = TabbarViewModel.Input(addContacts: rightBarButton.rx.tap.asSignal())

        let output = viewModel.transform(input)

        disposeBag.insert([output.contactsOutput.emit()])
    }
    
    func setControllers() {
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
