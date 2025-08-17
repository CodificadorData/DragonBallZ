//
//  HomeRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import UIKit
import SwiftKeychainWrapper

final class HomeRouter: HomeRouterProtocol {
    
    var viewController: UIViewController?
        
    static func createModule() -> UIViewController {
        let router = HomeRouter()
        let interactor = HomeInteractor()
        let presenter = HomePresenter(homeInteractor: interactor, router: router)
        let view = HomeView()
        router.viewController = view
        presenter.view = view
        view.presenter = presenter
        return view
    }
    
    func goToCharacterDetail(dragonBallModel: Item) {
        let charactersView = CharacterViewController(dragonBallModel: dragonBallModel)
        viewController?.navigationController?.pushViewController(charactersView, animated: true)
    }
                
}

protocol HomeRouterProtocol: AnyObject, RouterProtocol {
    static func createModule() -> UIViewController
    func goToCharacterDetail(dragonBallModel: Item)
}
