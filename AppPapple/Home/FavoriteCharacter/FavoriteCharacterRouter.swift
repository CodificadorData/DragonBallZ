//
//  FavoriteCharacterRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 25/08/25.
//

import UIKit

class FavoriteCharacterRouter: RouterProtocol {
    var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let interactor = FavoriteCharacterInteractor()
        let presenter = FavoriteCharacterPresenter(interactor: interactor)
        let view = FavoriteCharacterView()
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
