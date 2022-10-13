//
//  Dependancies.swift
//  TestTaskManagerApp
//
//  Created by Niko on 11.10.22.
//

import Foundation
import Resolver

extension Resolver.Name {
    static let mainWindow = Self("mainWindow")
}

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerScreens()
    }
    
    private static func registerScreens() {
        register(name: .mainWindow) { UIWindow() }.scope(.application)
        
        register { AppNavigator(userRepository: $0.resolve(), window: $0.resolve(name: .mainWindow)) }
        
        registerTabbarPage()
        registerMainPage()
        registerProfilePage()
        registerLoginPage()
        registerSignUpPage()
        registerRealmMigrator()
        registerUserRepository()
        registerTaskRepository()
        registerNewTaskPage()
        registerTaskDetailPage()
    }
    
    
    private static func registerTabbarPage() {
        register(ITabbarNavigator.self) { TabbarNavigator(viewController: $1.get()) }
        register(ITabbarViewModel.self) { TabbarViewModel(navigator: $0.resolve(args: $1.get())) }
        register(ITabbarViewController.self) { TabbarViewController() } .resolveProperties { $1.viewModel = $0.optional(args: $1) }
    }
    
    private static func registerMainPage() {
        register(IMainPageNavigator.self) { MainPageNavigator(viewController: $1.get()) }
        register(IMainPageViewModel.self) { MainPageViewModel(navigator: $0.resolve(args: $1.get()), taskRepository: $0.resolve()) }
        register(IMainPageViewController.self) { MainPageViewController() } .resolveProperties { $1.viewModel = $0.optional(args: $1) }
    }
    
    
    private static func registerProfilePage() {
        register(IProfileNavigator.self) { ProfileNavigator(viewController: $1.get()) }
        register(IProfileViewModel.self) { ProfileViewModel(userRepository: $0.resolve(), navigator: $0.resolve(args: $1.get())) }
        register(IProfileViewController.self) { ProfileViewController() } .resolveProperties { $1.viewModel = $0.optional(args: $1) }
    }
    
    private static func registerLoginPage() {
        register(ILoginNavigator.self) { LoginNavigator(viewController: $1.get()) }
        register(ILoginViewModel.self) { LoginViewModel(userRepository: $0.resolve(), navigator: $0.resolve(args: $1.get())) }
        register(ILoginViewController.self) { LoginViewController() }
            .resolveProperties { $1.viewModel = $0.optional(args: $1) }
    }
    
    private static func registerSignUpPage() {
        register(ISignUpNavigator.self) { SignUpNavigator(viewController: $1.get()) }
        register(ISignUpViewModel.self) { SignUpViewModel(userRepository: $0.resolve(), navigator: $0.resolve(args: $1.get())) }
        register(ISignUpViewController.self) { SignUpViewController() }
            .resolveProperties { $1.viewModel = $0.optional(args: $1) }
    }
    
    private static func registerNewTaskPage() {
        register(INewTaskNavigator.self) { NewTaskNavigator(viewController: $1.get()) }
        register(INewTaskViewModel.self) { NewTaskViewModel(navigator: $0.resolve(args: $1.get()), taskRepository: $0.resolve(), userRepository: $0.resolve()) }
        register(INewTaskViewController.self) { NewTaskViewController() }
            .resolveProperties { $1.viewModel = $0.optional(args: $1) }
    }
    
    private static func registerTaskDetailPage() {
        register(ITaskDetailNavigator.self) {
            TaskDetailNavigator(
            viewController: $1.get())
            
        }
        
        register(ITaskDetailViewModel.self) {
            TaskDetailViewModel(
            navigator: $0.resolve(args: $1.get("vc")),
            taskRepository: $0.resolve(),
            userRepository: $0.resolve(),
            task: $1.get("task"))
        }
        
        register(ITaskDetailViewController.self) {
            TaskDetailViewController() }
            .resolveProperties {
                let args: [String : Any] = [
                    "vc" : $1,
                    "task" : $2.get("task") as TaskModel,
                ]
                $1.viewModel = $0.optional(args: args)
                
            }
    }
    
}
