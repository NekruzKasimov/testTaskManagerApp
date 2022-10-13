//
//  ProfileViewController.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
import UIKit

protocol IProfileScreen: AnyObject {
    var viewModel: IProfileViewModel! { set get }
}

typealias IProfileViewController = BaseViewController & IProfileScreen

class ProfileViewController: IProfileViewController {
    var viewModel: IProfileViewModel!
    let signOutButton = AcceptButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
    }
    
    func bind() {
        let input = ProfileViewModel.Input(signOut: signOutButton.rx.tap.asSignal())
        
        let output = viewModel.transform(input)
        
        disposeBag.insert(output.signOutAction.emit())
    }
    
    func setupView() {
        
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = R.string.localizable.profilePageTitle()
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        signOutButton.setTitle(R.string.localizable.profilePageSignOutButtonTitle(), for: .normal)
        view.addSubview(signOutButton)
        signOutButton.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(-20)
            $0.trailing.equalToSuperview().offset(20)
        }
    }
}
