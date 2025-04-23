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
    var modelProduct: [Results] = []
    var page: String?
    let token = KeychainWrapper.standard.string(forKey: "authToken") ?? ""
    let router: HomeRouter
    
    init(homeInteractor: HomeInteractor, router: HomeRouter) {
        self.homeInteractor = homeInteractor
        self.router = router
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
    
    func updateUserData(user :NewUserEntity) {
        homeInteractor.updateUserData(user: user, authorizationToken: token) { dataJson in
            self.view?.updateUserData(dataUser: dataJson)
        }
    }
    
    func fetchProducts() {
        homeInteractor.fetchProducts { dataJson in
            switch dataJson {
            case .success(let products):
                self.view?.updateProductList(product: dataJson)
                self.modelProduct.append(contentsOf: products.results)
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
    
    func goToCharacterDetail(dragonBallModel: Item){
        router.goToCharacterDetail(mainView: self.view!, dragonBallModel: dragonBallModel)
    }

    func goToLogin(windows: UIWindow?){
        router.goToLogin(windows: windows)
    }
    
    func goToSocialMedia(socialMedia: String){
        router.goToSocialMedia(mainView: self.view!, socialMedia: socialMedia)
    }
    
}

protocol HomeViewProtocol: AnyObject {
    func updateDragonBall(dragonBallList: [Item])
    func fetchSettings(data: NewUserEntity)
    func updateUserData(dataUser: Result<NewUserEntity, Error>)
    func updateProductList(product: Result<ProductEntity, Error>)
}
