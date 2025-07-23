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
    var storeView: StoreViewProtocol?
    var modelDragon: [Item] = []
    var modelProduct: [Results] = []
    var page: String?
    var pageProduct: String?
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
                self.view?.errorPopUp(title: "error requestDragonBall", message: error.localizedDescription)
            }
        })
    }
    
    func fetchProducts() {
        homeInteractor.fetchProducts(url: pageProduct, dataResponse: { dataJson in
            switch dataJson {
            case .success(let products):
                self.modelProduct.append(contentsOf: products.results)
                self.storeView?.updateProductList(product: products)
                self.pageProduct = products.info.next
            case .failure(let error):
                self.view?.errorPopUp(title: "error fetchProducts", message: error.localizedDescription)
            }
        })
    }

    func fetchSettings() {
        homeInteractor.fetchUserData(authorizationToken: token) { dataJson in
            switch dataJson {
            case .success(let token):
                self.view?.fetchSettings(data: token)
            case .failure(let error):
                self.view?.errorPopUp(title: "error fetchSettings", message: error.localizedDescription)
            }
        }
    }
    
    func updateUserData(user :NewUserEntity) {
        homeInteractor.updateUserData(user: user, authorizationToken: token) { dataJson in
            switch dataJson {
            case .success(let data):
                self.view?.updateUserData(dataUser: data)
            case .failure(let error):
                self.view?.errorPopUp(title: "error updateUserData", message: error.localizedDescription)
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
    func updateUserData(dataUser: NewUserEntity)
    func errorPopUp(title: String, message: String)
}

protocol StoreViewProtocol: AnyObject {
    func updateProductList(product: ProductEntity)
    func errorPopUp(title: String, message: String)
}
