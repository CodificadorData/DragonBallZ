//
//  MainRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 1/01/25.
//
import UIKit

final class MainRouter {
    
    static let shared = MainRouter()
    
    weak var windows: UIWindow?
    
    func start(windows: UIWindow?) {
        self.windows = windows
    }
    
    func goToLogin(){
        let loginModule = LoginRouter.createModule()
        let navigationController = UINavigationController(rootViewController: loginModule)
        windows?.rootViewController = navigationController
        windows?.makeKeyAndVisible()
    }
    
    func goToHome(){
        let homeModule = HomeRouter.createModule()
        let navigationController = UINavigationController(rootViewController: homeModule)
        windows?.rootViewController = navigationController
        windows?.makeKeyAndVisible()
    }
}
