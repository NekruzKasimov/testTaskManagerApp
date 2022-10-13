//
//  LoginViewController.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

protocol ILoginScreen: AnyObject {
    var viewModel: ILoginViewModel! { get set }
}

typealias ILoginViewController = BaseViewController & ILoginScreen

class LoginViewController: ILoginViewController {
    var viewModel: ILoginViewModel!
    let usernameTF = InputTextField()
    let passwordTF = InputTextField()
    let acceptButton = AcceptButton()
    let signUpButton = AcceptButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        hideKeyboardWhenTappedAround()
        bind()
    }
    
    private func bind() {
        let input = LoginViewModel.Input(
            username: usernameTF.rx.text.orEmpty.asDriver(),
            password: passwordTF.rx.text.orEmpty.asDriver(),
            accept: acceptButton.rx.tap.asSignal(),
            signUp: signUpButton.rx.tap.asSignal())
        
        let output = viewModel.transform(input)
        
        disposeBag.insert([output.shouldLogin.emit(), output.signUpAction.emit()])
    }
    
    func setupView() {
        view.backgroundColor = .white
        usernameTF.placeholder = R.string.localizable.loginUsernamePlaceholder()
        passwordTF.placeholder = R.string.localizable.loginPasswordPlaceholder()
        signUpButton.setTitle(R.string.localizable.loginSignUpButtonTitle(), for: .normal)
        
        let textFieldsStackView = UIStackView()
        textFieldsStackView.spacing = 10
        textFieldsStackView.axis = .vertical
        textFieldsStackView.addArrangedSubview(usernameTF)
        textFieldsStackView.addArrangedSubview(passwordTF)
        
        view.addSubview(textFieldsStackView)
        
        textFieldsStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
        
        view.addSubview(acceptButton)
        view.addSubview(signUpButton)
        
        acceptButton.snp.makeConstraints {
            $0.top.equalTo(textFieldsStackView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(acceptButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
        }
    }
}
