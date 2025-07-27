//
//  RegisterRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 6/01/25.
//
import UIKit

class RegisterRouter {
    
    static func createModule() -> UIViewController {
        let registerRouter = RegisterRouter()
        let registerInteractor = RegisterInteractor()
        let registerPresenter = RegisterPresenter(interactor: registerInteractor, router: registerRouter)
        let registerViewController = RegisterViewController()
        
        registerPresenter.view = registerViewController
        registerViewController.presenter = registerPresenter
        return registerViewController
    }
    
    func goToLogin(mainView: UIViewController) {
        mainView.navigationController?.popViewController(animated: true)
    }
    
}
