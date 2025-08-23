//
//  HomePresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import SwiftKeychainWrapper

final class HomePresenter: HomePresenterProtocol {
    
    typealias RouterType = HomeRouter
    
    private let homeInteractor: HomeInteractor
    weak var view: HomeViewProtocol?
    private var storeView: StoreViewProtocol?
    private var settingsView: SettingsViewProtocol?
    private var socialView: SocialViewProtocol?
    var modelDragon: [Item] = []
    var page: String?
    var router: RouterType
    
    init(homeInteractor: HomeInteractor, router: RouterType) {
        self.homeInteractor = homeInteractor
        self.router = router
    }
    
    func bringData() {
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
        
    func goToCharacterDetail(dragonBallModel: Item){
        router.goToCharacterDetail(dragonBallModel: dragonBallModel)
    }

}

protocol HomePresenterProtocol: AnyObject, PresenterProtocol {
    func bringData()
    func goToCharacterDetail(dragonBallModel: Item)
}

protocol HomeViewProtocol: AnyObject {
    func updateDragonBall(dragonBallList: [Item])
    func errorPopUp(title: String, message: String)
}
