//
//  MainPageViewModel.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt

protocol IMainPageViewModel {
}

struct MainPageViewModel: IMainPageViewModel {
    var navigator: IMainPageNavigator
    
}
