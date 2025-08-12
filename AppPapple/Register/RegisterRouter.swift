//
//  RegisterRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 6/01/25.
//
import UIKit

class RegisterRouter: RegisterRouterProtocol {
    var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let router = RegisterRouter()
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter(interactor: interactor, router: router)
        let view = RegisterViewController()
        presenter.view = view
        view.presenter = presenter
        router.viewController = view
        return view
    }
    
    func goToLogin() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
}

protocol RegisterRouterProtocol: AnyObject, RouterProtocol {
    static func createModule() -> UIViewController
    func goToLogin()
}
