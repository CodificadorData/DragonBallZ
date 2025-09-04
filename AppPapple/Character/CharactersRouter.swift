//
//  CharactersRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import UIKit

final class CharactersRouter: CharactersRouterProtocol {
    
    var viewController: UIViewController?
    
    static func createModule(item: Item) -> UIViewController {
        let interactor = CharactersInteractor()
        let router = CharactersRouter()
        let presenter = CharacterPresenter(interactor: interactor, router: router)
        let view = CharacterViewController(dragonBallModel: item)
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        router.viewController = view
        return view
    }
    
    func goToHome() {
        viewController?.navigationController?.popViewController(animated: true)
        viewController?.navigationController?.isToolbarHidden = false
    }
    
}

protocol CharactersRouterProtocol: AnyObject, RouterProtocol {
    static func createModule(item: Item) -> UIViewController
    func goToHome()
}
