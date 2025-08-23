//
//  SettingsRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 10/08/25.
//

import UIKit

final class SettingsRouter: SettingsRouterProtocol {
    var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let interactor = SettingsInteractor()
        let router = SettingsRouter()
        let presenter = SettingsPresenter(interactor: interactor, router: router)
        let view = SettingsViewController()
        presenter.view = view
        view.presenter = presenter
        router.viewController = view
        return view
    }
    
    func goToLogin(){
        MainRouter.shared.goToLogin()
    }

}

protocol SettingsRouterProtocol: AnyObject, RouterProtocol {
    static func createModule() -> UIViewController
    func goToLogin()
}
