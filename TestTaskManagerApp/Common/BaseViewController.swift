//
//  BaseViewController.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        hideKeyboardWhenTappedAround()
    }
}
