//
//  StoreRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 10/08/25.
//

import UIKit

final class StoreRouter: StoreRouterProtocol {
    var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let interactor = StoreInteractor()
        let router = StoreRouter()
        let presenter = StorePresenter(interactor: interactor, router: router)
        let view = StoreViewController()
        presenter.view = view
        view.presenter = presenter
        router.viewController = view
        return view
    }
}

protocol StoreRouterProtocol: AnyObject, RouterProtocol {
    static func createModule() -> UIViewController
}
