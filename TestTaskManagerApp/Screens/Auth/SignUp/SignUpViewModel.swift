//
//  SignUpViewModel.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import RxCocoa
import RxSwift

protocol ISignUpViewModel {
    func transform(_ input: SignUpViewModel.Input) -> SignUpViewModel.Output
}

struct SignUpViewModel: ISignUpViewModel {
    var userRepository: IUserRepository
    var navigator: ISignUpNavigator
    
    func transform(_ input: Input) -> Output {
        
        let fields = Driver.combineLatest(input.name, input.lastName, input.username, input.password)
        
        let result = input.accept
            .withLatestFrom(fields)
            .filter({ name, lastname, username, password in
                if name.isEmpty || lastname.isEmpty || username.isEmpty || password.isEmpty {
                    navigator.fillUpFieldsAlert()
                }
                return !name.isEmpty && !lastname.isEmpty && !username.isEmpty && !password.isEmpty
            })
            .map { name, lastName, userName, password in
                let user = UserModel()
                user.name = name
                user.password = password
                user.lastName = lastName
                user.username = userName
                userRepository.saveUser(user)
                navigator.signUp()
            }
        
        return Output(signUpAction: result)
    }
}


extension SignUpViewModel {
    struct Input {
        let name: Driver<String>
        let lastName: Driver<String>
        let username: Driver<String>
        let password: Driver<String>
        let accept: Signal<Void>
    }
    
    struct Output {
        let signUpAction: Signal<Void>
    }
}
