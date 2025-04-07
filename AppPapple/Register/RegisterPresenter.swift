//
//  RegisterPresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 6/01/25.
//

class RegisterPresenter {
    
    let interactor = RegisterInteractor()
    
    func registerUser(user: NewUserEntity) {
        interactor.registerUser(user: user)
    }
}
