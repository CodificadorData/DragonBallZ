//
//  HomeRouter.swift
//  ExampleBanner
//
//  Created by Christian Morante on 18/02/24.
//

import Foundation
import UIKit

class DragonBallRouter {
    
    func startDragonBall(windows: UIWindow?){
        let view = DragonBallView()
        let interactor = DragonBallInteractor()
        let presenter = DragonBallPresenter(dragonBallInteractor: interactor)
        presenter.ui = view
        view.presenter = presenter
        let navigationController = UINavigationController(rootViewController: view)
        windows?.rootViewController = navigationController
        windows?.makeKeyAndVisible()
        
    }

}
