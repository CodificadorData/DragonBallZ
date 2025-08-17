//
//  RegisterPresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 6/01/25.
//

import UIKit

protocol RegisterViewProtocol: AnyObject {
    func registerUser(data: Result<ResponseRegister, Error>)
}

final class RegisterPresenter: RegisterPresenterProtocol {
    
    var router: RegisterRouter
    var interactor: RegisterInteractor
    weak var view: RegisterViewProtocol?
    
    init(interactor: RegisterInteractor, router: RegisterRouter) {
        self.interactor = interactor
        self.router = router
    }
    func registerUser(user: NewUserEntity) {
        interactor.registerUser(user: user) { dataJson in
            self.view?.registerUser(data: dataJson)
        }
    }
    
    func goToLogin() {
        router.goToLogin()
    }
}

protocol RegisterPresenterProtocol: AnyObject {
    func registerUser(user: NewUserEntity)
    func goToLogin()
}
