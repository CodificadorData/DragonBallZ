//
//  LoginRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 5/01/25.
//

import UIKit

class LoginRouter {
    
    private var homeView: HomeView?
    
    func goToHome() {
        MainRouter.shared.goToHome()
    }
    
    func goToRegister(mainView: UIViewController) {
        let registerRouter = RegisterRouter()
        let registerInteractor = RegisterInteractor()
        let registerPresenter = RegisterPresenter(interactor: registerInteractor, router: registerRouter)
        let registerViewController = RegisterViewController()
        
        registerPresenter.view = registerViewController
        registerViewController.presenter = registerPresenter
        
        mainView.navigationController?.pushViewController(registerViewController, animated: true)
    }
}
