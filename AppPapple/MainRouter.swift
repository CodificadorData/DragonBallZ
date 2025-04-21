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
    var loginRouter: LoginRouter
    
    init() {
        self.loginRouter = LoginRouter()
        self.loginInteractor = LoginInteractor()
        self.loginPresenter = LoginPresenter(interactor: loginInteractor, router: loginRouter)
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
        let homeRouter = HomeRouter()
        let homeInteractor = HomeInteractor()
        let homePresenter = HomePresenter(homeInteractor: homeInteractor, router: homeRouter)
        let homeView = HomeView()
        
        homePresenter.view = homeView
        homeView.presenter = homePresenter
        
        let navigationController = UINavigationController(rootViewController: homeView)
        windows?.rootViewController = navigationController
        windows?.makeKeyAndVisible()
    }
}
