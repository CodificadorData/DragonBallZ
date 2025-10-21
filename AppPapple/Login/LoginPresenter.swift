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

final class LoginPresenter: LoginPresenterProtocol {
    private let interactor: LoginInteractor
    var view: LoginViewProtocol?
    var router: LoginRouter
    
    init(interactor: LoginInteractor, router: LoginRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func validateUser(email: String, password: String) {
        interactor.validateUser(email: email, password: password) { dataUser in
            self.view?.validateUser(dataJson: dataUser)
        }
    }
    
    func validateUserBiometrics(){
        interactor.validateUserBiometrics(){ dataUser in
            self.view?.validateUser(dataJson: dataUser)
        }
    }

    func consultBiometricsFlag() -> Bool {
        return interactor.consultBiometricsFlag()
    }
    
    func goToRegister() {
        router.goToRegister()
    }
    
    func goToHome() {
        router.goToHome()
    }
}

protocol LoginPresenterProtocol: AnyObject {
    func validateUser(email: String, password: String)
    func goToRegister()
    func goToHome()
}
