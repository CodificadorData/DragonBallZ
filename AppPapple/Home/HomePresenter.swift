//
//  HomePresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import SwiftKeychainWrapper

class HomePresenter {
    
    private let homeInteractor: HomeInteractor
    var view: HomeViewProtocol?
    var modelDragon: [Item] = []
    var page: String?
    let token = KeychainWrapper.standard.string(forKey: "authToken") ?? ""

    init(homeInteractor: HomeInteractor) {
        self.homeInteractor = HomeInteractor()
    }
        
    func bringData(){
        homeInteractor.requestDragonBall(url: page, dataJson: { dataDragon in
            switch dataDragon {
            case .success(let response):
                self.modelDragon.append(contentsOf: response.items)
                self.view?.updateDragonBall(dragonBallList: self.modelDragon)
                self.page = response.links.next
            case .failure(let error):
                print(error)
            }
        })
    }

    func fetchSettings() {
        homeInteractor.fetchUserData(authorizationToken: token) { dataJson in
            self.view?.fetchSettings(data: dataJson)
        }
    }
    
    func updateUserData(name: String, surName: String, phoneNumber: String, email: String, imageProfile: String, password: String) {
        homeInteractor.updateUserData(name: name, surName: surName, phoneNumber: phoneNumber, email: email, authorizationToken: token, imageProfile: imageProfile, password: password) { dataJson in
            self.view?.updateUserData(dataUser: dataJson)
        }
    }

}

protocol HomeViewProtocol: AnyObject {
    func updateDragonBall(dragonBallList: [Item])
    func fetchSettings(data: NewUserEntity)
    func updateUserData(dataUser: Result<NewUserEntity, Error>)
}
