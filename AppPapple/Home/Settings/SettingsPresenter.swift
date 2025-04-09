//
//  SettingsPresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 7/04/25.
//

import Foundation

class SettingsPresenter {
    var interactor: SettingsInteractor?
    
    init(interactor: SettingsInteractor? = nil) {
        self.interactor = interactor
    }
    
    func fetchSettings(data: @escaping (_ dataJson: NewUserEntity) -> Void) {
        interactor?.fetchUserData { dataJson in
            data(dataJson)
        }
    }
}


