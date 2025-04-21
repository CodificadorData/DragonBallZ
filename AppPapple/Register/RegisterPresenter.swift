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

class RegisterPresenter {
    
    var router: RegisterRouter
    let interactor: RegisterInteractor
    weak var view: RegisterViewProtocol?
    
    init(interactor: RegisterInteractor) {
        self.interactor = interactor
        self.router = RegisterRouter()
    }
    func registerUser(user: NewUserEntity) {
        interactor.registerUser(user: user) { dataJson in
            self.view?.registerUser(data: dataJson)
        }
    }
    
    func goToLogin(mainView: UIViewController) {
        router.goToLogin(mainView: mainView)
    }
}
