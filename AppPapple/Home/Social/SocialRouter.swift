//
//  SocialRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 10/08/25.
//

import UIKit

class SocialRouter: SocialRouterProtocol {
    var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let interactor = SocialInteractor()
        let router = SocialRouter()
        let presenter = SocialPresenter(interactor: interactor, router: router)
        let view = SocialViewController()
        presenter.view = view
        view.presenter = presenter
        router.viewController = view
        return view
    }
    
    func showSongsList(songsList: [SongsEntity]) {
        let songsListView = SongsListView(songsList: songsList )
        viewController?.navigationController?.present(songsListView, animated: true)
    }

}

protocol SocialRouterProtocol: AnyObject, RouterProtocol {
    static func createModule() -> UIViewController
    func showSongsList(songsList: [SongsEntity])
}
