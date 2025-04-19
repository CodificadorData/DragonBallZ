//
//  LoginRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 5/01/25.
//

import UIKit

class LoginRouter {
    
    private var homeViewController: HomeViewController?
    private var registerViewController: RegisterViewController?
    
    func goToHome(windows: UIWindow?) {
        let homeInteractor = HomeInteractor()
        let homePresenter = HomePresenter(homeInteractor: homeInteractor)
        self.homeViewController = HomeViewController()
        self.homeViewController?.presenter  = homePresenter
        homePresenter.view = homeViewController
        self.homeViewController?.presenter = homePresenter
        let navigationController = UINavigationController(rootViewController: homeViewController!)
        windows?.windowScene?.keyWindow?.rootViewController = navigationController
        windows?.windowScene?.keyWindow?.makeKeyAndVisible()
    }
    
    func goToRegister(mainView: UIViewController) {
        self.registerViewController = RegisterViewController()
        mainView.navigationController?.pushViewController(registerViewController!, animated: true)
    }
}
