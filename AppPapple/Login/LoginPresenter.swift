//
//  LoginPresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 5/01/25.
//

import Foundation

class LoginPresenter {
    var interactor: LoginInteractor?
    
    init(interactor: LoginInteractor) {
        self.interactor = LoginInteractor()
    }
    
    func validateUser(email: String, password: String, dataUser: @escaping (_ dataJson: Result<ResponseUser, Error>) -> Void) {
        interactor?.validateUser(email: email, password: password) { dataJson in
            dataUser(dataJson)
        }
    }
    
    func login(userID: String, password: String) {
        
    }
    
}
