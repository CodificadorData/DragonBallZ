//
//  SceneDelegate.swift
//  AppPapple
//
//  Created by Christian Alexander Morante Santander on 27/12/23.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        MainRouter.shared.start(windows: window)
        verifyLogin()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        verifyLogin()
    }
    
    func verifyLogin() {
        if let token = KeychainWrapper.standard.string(forKey: "authToken") {
            MainRouter.shared.goToHome()
        } else {
            MainRouter.shared.goToLogin()
        }

    }
}
