//
//  LoginRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 5/01/25.
//

import UIKit

class LoginRouter: RouterProtocol {
    var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let router = LoginRouter()
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(interactor: interactor, router: router)
        let view = LoginViewController()
        view.presenter = presenter
        presenter.view = view
        router.viewController = view
        return view
    }
    
    func goToHome() {
        MainRouter.shared.goToHome()
    }
    
    func goToRegister() {
        let registerModule = RegisterRouter.createModule()
        viewController?.navigationController?.pushViewController(registerModule, animated: true)
    }
    
}

protocol LoginRouterProtocol: AnyObject, RouterProtocol {
    static func createModule() -> UIViewController
    func goToHome()
    func goToRegister()
}
