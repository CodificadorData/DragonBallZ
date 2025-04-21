//
//  LoginPresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 5/01/25.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func validateUser(dataJson: Result<ResponseUser, Error>)
}

class LoginPresenter {
    var interactor: LoginInteractor?
    var view: LoginViewProtocol?
    var router: LoginRouter?
    
    init(interactor: LoginInteractor) {
        self.interactor = interactor
        self.router = LoginRouter()
    }
    
    func validateUser(email: String, password: String) {
        interactor?.validateUser(email: email, password: password) { dataJson in
            self.view?.validateUser(dataJson: dataJson)
        }
    }

    func goToRegister(mainView: UIViewController) {
        router?.goToRegister(mainView: mainView)
    }
}


