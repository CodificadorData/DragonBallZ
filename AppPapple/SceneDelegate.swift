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
    let router = MainRouter()
    let loginRouter = LoginRouter()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        router.start(windows: window)
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        if (KeychainWrapper.standard.string(forKey: "accessToken") != nil) {
            loginRouter.goToHome(windows: window)
        } else {
            router.start(windows: window)
        }
    }
    
}
