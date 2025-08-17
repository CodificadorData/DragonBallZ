//
//  SettingsPresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 10/08/25.
//

import SwiftKeychainWrapper

final class SettingsPresenter: SettingsPresenterProtocol {
    typealias RouterType = SettingsRouter
    
    let interactor: SettingsInteractor
    var router: RouterType
    weak var view: SettingsViewProtocol?
    let token = KeychainWrapper.standard.string(forKey: "authToken") ?? ""

    init(interactor: SettingsInteractor, router: RouterType) {
        self.interactor = interactor
        self.router = router
    }
    
    func fetchUserData() {
        interactor.fetchUserData(authorizationToken: token) { dataJson in
            switch dataJson {
            case .success(let userData):
                self.view?.fetchUserData(data: userData)
            case .failure(let error):
                self.view?.errorPopUp(title: "error fetchSettings", message: error.localizedDescription)
            }
        }
    }
    
    func updateUserData(user :NewUserEntity) {
        interactor.updateUserData(user: user, authorizationToken: token) { dataJson in
            switch dataJson {
            case .success(let data):
                self.view?.updateUserData(dataUser: data)
            case .failure(let error):
                self.view?.errorPopUp(title: "error updateUserData", message: error.localizedDescription)
            }
        }
    }
    
    func goToLogin(){
        router.goToLogin()
    }


}

protocol SettingsPresenterProtocol: AnyObject, PresenterProtocol {
    func fetchUserData()
    func updateUserData(user :NewUserEntity)
    func goToLogin()
}

protocol SettingsViewProtocol: AnyObject {
    func updateUserData(dataUser: NewUserEntity)
    func errorPopUp(title: String, message: String)
    func fetchUserData(data: NewUserEntity)
}
