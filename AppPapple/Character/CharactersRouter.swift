//
//  CharactersRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import UIKit

class CharactersRouter {
    
    var viewController: CharacterViewController?
    
    static func createModule(item: Item) -> CharacterViewController {
        let interactor = CharactersInteractor()
        let router = CharactersRouter()
        let presenter = CharacterPresenter(interactor: interactor, router: router)
        let view = CharacterViewController(dragonBallModel: item)
        presenter.router = router
        view.presenter = presenter
        router.viewController = view
        return view
    }
    
    func goToHome(main: UINavigationController?) {
        main?.popViewController(animated: true)
        main?.isToolbarHidden = false
    }
    
}
