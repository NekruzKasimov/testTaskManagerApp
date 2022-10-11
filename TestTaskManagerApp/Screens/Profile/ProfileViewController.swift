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
}
