//
//  BaseRouter.swift
//  AppPapple
//
//  Created by Christian Morante on 11/08/25.
//
import UIKit

protocol RouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    
    func goToContactView()
    func goToSettingsView()
    func goToStoreView()
    func goToSocialView()
    func gotoHome()
}

extension RouterProtocol {
    func goToContactView() {
        let contactView = ContactRouter.createModule()
        viewController?.navigationController?.pushViewController(contactView, animated: false)
    }
    
    func goToSettingsView() {
        let settingsView = SettingsRouter.createModule()
        viewController?.navigationController?.pushViewController(settingsView, animated: false)
    }
    
    func goToStoreView() {
        let storeView = StoreRouter.createModule()
        viewController?.navigationController?.pushViewController(storeView, animated: false)
    }

    func goToSocialView() {
        let socialView = SocialRouter.createModule()
        viewController?.navigationController?.pushViewController(socialView, animated: false)
    }
    
    func gotoHome() {
        let homeView = HomeRouter.createModule()
        viewController?.navigationController?.pushViewController(homeView, animated: false)
    }

}
