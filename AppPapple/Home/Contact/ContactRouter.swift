//
//  ContactRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 10/08/25.
//

import UIKit

class ContactRouter: ContactRouterProtocol {
    
    var viewController: UIViewController?
    
    static func createModule() -> ContactViewController {
        let interactor = ContactInteractor()
        let view = ContactViewController()
        let router = ContactRouter()
        let presenter = ContactPresenter(interactor: interactor, router: router)
        router.viewController = view
        presenter.view = view
        view.presenter = presenter
        return view
    }
    
    func goToSocialMedia(mainView: AnyObject, socialMedia: SocialMedia){
        let webView = WebViews()
        webView.urlString = socialMedia.rawValue
        viewController?.present(webView, animated: true)
    }

}

protocol ContactRouterProtocol: AnyObject, RouterProtocol {
    static func createModule() -> ContactViewController
    func goToSocialMedia(mainView: AnyObject, socialMedia: SocialMedia)
}
