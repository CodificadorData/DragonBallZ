//
//  LoginPresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 5/01/25.
//

protocol LoginViewProtocol: AnyObject {
    func validateUser(dataJson: Result<ResponseUser, Error>)
}

class LoginPresenter {
    var interactor: LoginInteractor?
    var view: LoginViewProtocol?

    init(interactor: LoginInteractor) {
        self.interactor = LoginInteractor()
    }
    
    func validateUser(email: String, password: String) {
        interactor?.validateUser(email: email, password: password) { dataJson in
            self.view?.validateUser(dataJson: dataJson)
        }
    }

}


