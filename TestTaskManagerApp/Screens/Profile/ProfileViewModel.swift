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
}

struct ProfileViewModel: IProfileViewModel {
    var navigator: IProfileNavigator
}
