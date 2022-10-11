//
//  MainPageViewController.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol IMainScreen: AnyObject {
    var viewModel: IMainPageViewModel! { get set }
}

typealias IMainPageViewController = BaseViewController & IMainScreen

final class MainPageViewController: IMainPageViewController {
    var viewModel: IMainPageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white
    }
}
