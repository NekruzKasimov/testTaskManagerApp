//
//  ProfileViewModel.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
import RxSwift
import RxCocoa

protocol IProfileViewModel {
    func transform(_ input: ProfileViewModel.Input) -> ProfileViewModel.Output
}

struct ProfileViewModel: IProfileViewModel {
    var userRepository: IUserRepository
    var navigator: IProfileNavigator
    
    func transform(_ input: Input) -> Output {
        
        let result = input.signOut.do { _ in
            userRepository.signOutUser()
            navigator.restartApplication()
        }
        
        return Output(signOutAction: result)
    }
    
    
}

extension ProfileViewModel {
    struct Input {
        let signOut: Signal<Void>
    }
    
    struct Output {
        let signOutAction: Signal<Void>
    }
}
