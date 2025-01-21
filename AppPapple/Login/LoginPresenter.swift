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
    
    func validateUser(email: String, password: String) throws -> UserEntity {
        do {
            let result = try interactor?.validateUser(email: email, password: password)
            return result!
        } catch UserError.invalidData {
            print("Error: Algo salió mal.")
            throw UserError.invalidData
        }
    }
    
    func login(userID: String, password: String) {
        
    }
    
}
