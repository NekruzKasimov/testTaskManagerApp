//
//  TabbarViewModel.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
import RxSwift
import RxCocoa

protocol ITabbarViewModel {
}

struct TabbarViewModel: ITabbarViewModel {
    var navigator: ITabbarNavigator
    
}
