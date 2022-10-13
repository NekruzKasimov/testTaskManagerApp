//
//  LoginViewModel.swift
//  TestTaskManagerApp
//
//  Created by Niko on 13.10.22.
//

import Foundation
import RxCocoa
import RxSwift


protocol ILoginViewModel {
    func transform(_ input: LoginViewModel.Input) -> LoginViewModel.Output
}

struct LoginViewModel: ILoginViewModel {
    var userRepository: IUserRepository
    var navigator: ILoginNavigator
    
    func transform(_ input: Input) -> Output {
        
        let usernameAndPassword = Driver.combineLatest(input.username, input.password)
         
        let result = input.accept
            .withLatestFrom(usernameAndPassword)
            .filter({ username, password in
                if username.isEmpty || password.isEmpty {
                    navigator.fillUpFieldsAlert()
                }
                return !username.isEmpty && !password.isEmpty
            })
            .map { username, password in
                if let user = userRepository.getUser(by: username), user.password == password {
                    userRepository.signInUser(user)
                    navigator.signIn()
                } else {
                    navigator.wrongUserAlert()
                }
            }
        
        let signUpAction = input.signUp.do { _ in
            navigator.openSingUpPage()
        }
        
        return Output(shouldLogin: result, signUpAction: signUpAction)
        
    }
    
}

extension LoginViewModel {
    struct Input {
        let username: Driver<String>
        let password: Driver<String>
        let accept: Signal<Void>
        let signUp: Signal<Void>
    }
    
    struct Output {
        let shouldLogin: Signal<Void>
        let signUpAction: Signal<Void>
    }
}
