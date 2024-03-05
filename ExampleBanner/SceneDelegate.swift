//
//  SceneDelegate.swift
//  ExampleBanner
//
//  Created by Christian Alexander Morante Santander on 27/12/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let dragonBallRouter = DragonBallRouter()
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        dragonBallRouter.startDrgonBall(windows: window)
//        let viewController = DragonBallView()
//        let navigationController = UINavigationController(rootViewController: viewController)
//        self.window = UIWindow(windowScene: windowScene)
//        self.window?.rootViewController = navigationController
//        self.window?.makeKeyAndVisible()
    }

}
