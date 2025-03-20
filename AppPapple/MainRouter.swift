//
//  MainRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 1/01/25.
//
import UIKit

class MainRouter {
    
    var loginView: LoginViewController
    var loginPresenter: LoginPresenter
    var loginInteractor: LoginInteractor
    
    init() {
        self.loginInteractor = LoginInteractor()
        self.loginPresenter = LoginPresenter(interactor: loginInteractor)
        self.loginView = LoginViewController(presenter: loginPresenter)
        loginView.presenter = loginPresenter
    }
    
    func start(windows: UIWindow?){
        let navigationController = UINavigationController(rootViewController: loginView)
        windows?.rootViewController = navigationController
        windows?.makeKeyAndVisible()
    }
    
}
