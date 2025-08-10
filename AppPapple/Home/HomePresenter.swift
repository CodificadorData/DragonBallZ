//
//  HomePresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import SwiftKeychainWrapper

enum SocialMedia {
    case facebook
    case instagram
    case youtube
}
class HomePresenter {
    
    private let homeInteractor: HomeInteractor
    var view: HomeViewProtocol?
    var storeView: StoreViewProtocol?
    var settingsView: SettingsViewProtocol?
    var socialView: SocialViewProtocol?
    var modelDragon: [Item] = []
    var modelProduct: [Results] = []
    var modelNews: [News] = []
    var modelShorts: [ResultShort] = []
    var modelMultimedia: MultimediaEntityResult?
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
    
    func fetchUserData() {
        homeInteractor.fetchUserData(authorizationToken: token) { dataJson in
            switch dataJson {
            case .success(let userData):
                self.settingsView?.fetchUserData(data: userData)
            case .failure(let error):
                self.view?.errorPopUp(title: "error fetchSettings", message: error.localizedDescription)
            }
        }
    }
    
    func updateUserData(user :NewUserEntity) {
        homeInteractor.updateUserData(user: user, authorizationToken: token) { dataJson in
            switch dataJson {
            case .success(let data):
                self.settingsView?.updateUserData(dataUser: data)
            case .failure(let error):
                self.view?.errorPopUp(title: "error updateUserData", message: error.localizedDescription)
            }
        }
    }
    
    func fetchNews() {
        homeInteractor.fetchNews { dataJson in
            switch dataJson {
            case .success(let response):
                self.socialView?.fetchNews(news: response)
                self.modelNews = response.news
            case .failure(let error):
                self.view?.errorPopUp(title: "error fetchNews", message: error.localizedDescription)
            }
        }
    }
    
    func fetchShorts() {
        homeInteractor.fetchShorts { dataJson in
            switch dataJson {
            case .success(let response):
                self.socialView?.fetchShorts(shorts: response)
                self.modelShorts = response.results
            case .failure(let error):
                self.view?.errorPopUp(title: "error fetchShorts", message: error.localizedDescription)
            }
        }
    }
    
    func fetchMultimedia() {
        homeInteractor.fetchMultimedia { dataResponse in
            switch dataResponse {
            case .success(let response):
                self.socialView?.fetchMultimedia(multimedia: response)
                self.modelMultimedia = response.results
            case .failure(let error):
                self.view?.errorPopUp(title: "error fetchMultimedia", message: error.localizedDescription)
            }
        }
    }
    
    func goToCharacterDetail(dragonBallModel: Item){
        guard let view = view else { return }
        router.goToCharacterDetail(mainView: view, dragonBallModel: dragonBallModel)
    }
    
    func goToLogin(){
        router.goToLogin()
    }
    
    func goToSocialMedia(socialMedia: SocialMedia){
        guard let view = view else { return }
        router.goToSocialMedia(mainView: view, socialMedia: socialMedia)
    }
    
    func showSongsList(){
        guard let view = view else { return }
        router.showSongsList(mainView: view)
    }
}

protocol HomeViewProtocol: AnyObject {
    func updateDragonBall(dragonBallList: [Item])
    func errorPopUp(title: String, message: String)
}

protocol StoreViewProtocol: AnyObject {
    func updateProductList(product: ProductEntity)
    func errorPopUp(title: String, message: String)
}

protocol SettingsViewProtocol: AnyObject {
    func updateUserData(dataUser: NewUserEntity)
    func errorPopUp(title: String, message: String)
    func fetchUserData(data: NewUserEntity)
}

protocol SocialViewProtocol: AnyObject {
    func fetchNews(news: NewsEntity)
    func fetchShorts(shorts: ShortsEntity)
    func fetchMultimedia(multimedia: MultimediaEntity)
}
