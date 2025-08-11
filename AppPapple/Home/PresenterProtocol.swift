//
//  BasePresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 11/08/25.
//

protocol PresenterProtocol {
    associatedtype RouterType: RouterProtocol
    var router: RouterType { get set}
    
    func didTapContactButton()
    func didTapSettingstButton()
    func didTapStoreButton()
    func didTapSocialtButton()
}

extension PresenterProtocol {
    func didTapContactButton() {
        router.goToContactView()
    }
    
    func didTapSettingstButton() {
        router.goToSettingsView()
    }
    
    func didTapStoreButton() {
        router.goToStoreView()
    }

    func didTapSocialtButton() {
        router.goToSocialView()
    }

    func didTapHomeButton() {
        router.gotoHome()
    }

}
