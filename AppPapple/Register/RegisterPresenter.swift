//
//  RegisterPresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 6/01/25.
//
protocol RegisterViewProtocol: AnyObject {
    func registerUser(data: Result<ResponseRegister, Error>)
}

class RegisterPresenter {
    
    let interactor: RegisterInteractor
    weak var view: RegisterViewProtocol?
    
    init(interactor: RegisterInteractor) {
        self.interactor = interactor
    }
    func registerUser(user: NewUserEntity) {
        interactor.registerUser(user: user) { dataJson in
            self.view?.registerUser(data: dataJson)
        }
    }
    
}
