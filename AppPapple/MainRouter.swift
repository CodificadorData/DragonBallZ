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
        self.loginView = LoginViewController()
        loginView.presenter = loginPresenter
        loginPresenter.view = loginView
    }
    
    func startWithLogin(windows: UIWindow?){
        let navigationController = UINavigationController(rootViewController: loginView)
        windows?.rootViewController = navigationController
        windows?.makeKeyAndVisible()
    }
    
    func startWithHome(windows: UIWindow?){
        let homeInteractor = HomeInteractor()
        let homePresenter = HomePresenter(homeInteractor: homeInteractor)
        let homeView = HomeViewController()
        
        homePresenter.view = homeView
        homeView.presenter = homePresenter
        
        let navigationController = UINavigationController(rootViewController: homeView)
        windows?.rootViewController = navigationController
        windows?.makeKeyAndVisible()
    }
}
