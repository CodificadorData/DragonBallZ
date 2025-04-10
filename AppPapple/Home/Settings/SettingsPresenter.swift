//
//  SettingsPresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 7/04/25.
//

import Foundation
import SwiftKeychainWrapper

class SettingsPresenter {
    var interactor: SettingsInteractor?
    let token = KeychainWrapper.standard.string(forKey: "authToken") ?? ""
    
    init(interactor: SettingsInteractor? = nil) {
        self.interactor = interactor
    }
    
    func fetchSettings(data: @escaping (_ dataJson: NewUserEntity) -> Void) {
        interactor?.fetchUserData(authorizationToken: token) { dataJson in
            data(dataJson)
        }
    }
    
    func updateUserData(name: String, surName: String, phoneNumber: String, email: String, imageProfile: String, password: String, dataUser: @escaping (_ dataJson: Result<NewUserEntity, Error>) -> Void) {
        interactor?.updateUserData(name: name, surName: surName, phoneNumber: phoneNumber, email: email, authorizationToken: token, imageProfile: imageProfile, password: password) { dataJson in
            dataUser(dataJson)
        }
    }
}


