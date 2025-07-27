//
//  LoginRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 5/01/25.
//

import UIKit

class LoginRouter {
    
    static func createModule() -> UIViewController {
        let loginRouter = LoginRouter()
        let loginInteractor = LoginInteractor()
        let loginPresenter = LoginPresenter(interactor: loginInteractor, router: loginRouter)
        let loginView = LoginViewController()
        loginView.presenter = loginPresenter
        loginPresenter.view = loginView
        return loginView
    }
    
    func goToHome() {
        MainRouter.shared.goToHome()
    }
    
    func goToRegister(mainView: UIViewController) {
        let registerModule = RegisterRouter.createModule()
        mainView.navigationController?.pushViewController(registerModule, animated: true)
    }
    
}
