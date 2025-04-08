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
    
    func fetchSettings() {
        interactor?.fetchUserData { dataJson in
        }
    }
}
