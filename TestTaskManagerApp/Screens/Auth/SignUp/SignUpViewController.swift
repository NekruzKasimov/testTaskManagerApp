//
//  SignUpViewController.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa


protocol ISignUpPage: AnyObject {
    var viewModel: ISignUpViewModel! { set get }
}

typealias ISignUpViewController = BaseViewController & ISignUpPage

class SignUpViewController: ISignUpViewController {
    var viewModel: ISignUpViewModel!
    let nameTF = InputTextField()
    let lastNameTF = InputTextField()
    let usernameTF = InputTextField()
    let passwordTF = InputTextField()
    let acceptButton = AcceptButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        hideKeyboardWhenTappedAround()
        bind()
    }
    
    func bind() {
        let input = SignUpViewModel.Input(
            name: nameTF.rx.text.orEmpty.asDriver(),
            lastName: lastNameTF.rx.text.orEmpty.asDriver(),
            username: usernameTF.rx.text.orEmpty.asDriver(),
            password: passwordTF.rx.text.orEmpty.asDriver(),
            accept: acceptButton.rx.tap.asSignal())
        
        let output = viewModel.transform(input)
        
        disposeBag.insert(output.signUpAction.emit())
    }
    
    func setupView() {
        view.backgroundColor = .white
        
        nameTF.placeholder = R.string.localizable.signUpNamePlaceholder()
        lastNameTF.placeholder = R.string.localizable.signUpLastnamePlaceholder()
        usernameTF.placeholder = R.string.localizable.loginUsernamePlaceholder()
        passwordTF.placeholder = R.string.localizable.loginPasswordPlaceholder()
        
        let textFieldsStackView = UIStackView()
        textFieldsStackView.spacing = 10
        textFieldsStackView.axis = .vertical
        textFieldsStackView.addArrangedSubview(nameTF)
        textFieldsStackView.addArrangedSubview(lastNameTF)
        textFieldsStackView.addArrangedSubview(usernameTF)
        textFieldsStackView.addArrangedSubview(passwordTF)
        
        view.addSubview(textFieldsStackView)
        
        textFieldsStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
        
        view.addSubview(acceptButton)
        
        acceptButton.snp.makeConstraints {
            $0.top.equalTo(textFieldsStackView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
        }
        
    }
}
