//
//  HomeRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import UIKit
import SwiftKeychainWrapper

class HomeRouter {
    
    func goToCharacterDetail(mainView: UIViewController, dragonBallModel: Item) {
        let charactersView = CharacterViewController(dragonBallModel: dragonBallModel)
        mainView.navigationController?.pushViewController(charactersView, animated: true)
    }
    
    func goToLogin(windows: UIWindow?){
        KeychainWrapper.standard.removeObject(forKey: "authToken")
        let loginInteractor = LoginInteractor()
        let loginPresenter = LoginPresenter(interactor: loginInteractor)
        let loginView = LoginViewController()
        loginView.presenter = loginPresenter
        loginPresenter.view = loginView
        
        let navigationController = UINavigationController(rootViewController: loginView)
        windows?.windowScene?.keyWindow?.rootViewController = navigationController
        windows?.windowScene?.keyWindow?.makeKeyAndVisible()
    }
    
}
