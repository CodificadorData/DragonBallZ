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
        verifyLogin()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {

    }
    
    func verifyLogin() {
        MainRouter.shared.start(windows: window)
        if KeychainWrapper.standard.string(forKey: "authToken") != nil{
            MainRouter.shared.goToHome()
        } else {
            MainRouter.shared.goToLogin()
        }
    }
}
