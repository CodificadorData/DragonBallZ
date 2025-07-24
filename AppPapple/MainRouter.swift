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
        let loginRouter = LoginRouter()
        let loginInteractor = LoginInteractor()
        let loginPresenter = LoginPresenter(interactor: loginInteractor, router: loginRouter)
        let loginView = LoginViewController()
        loginView.presenter = loginPresenter
        loginPresenter.view = loginView
        let navigationController = UINavigationController(rootViewController: loginView)
        windows?.rootViewController = navigationController
        windows?.makeKeyAndVisible()
    }
    
    func goToHome(){
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
