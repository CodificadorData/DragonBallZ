//
//  HomePresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import SwiftKeychainWrapper

class HomePresenter: PresenterProtocol {
    
    typealias RouterType = HomeRouter
    
    private let homeInteractor: HomeInteractor
    var view: HomeViewProtocol?
    var storeView: StoreViewProtocol?
    var settingsView: SettingsViewProtocol?
    var socialView: SocialViewProtocol?
    var modelDragon: [Item] = []
    var page: String?
    var router: RouterType
    
    init(homeInteractor: HomeInteractor, router: RouterType) {
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
        
    func goToCharacterDetail(dragonBallModel: Item){
        guard let view = view else { return }
        router.goToCharacterDetail(mainView: view, dragonBallModel: dragonBallModel)
    }

}

protocol HomeViewProtocol: AnyObject {
    func updateDragonBall(dragonBallList: [Item])
    func errorPopUp(title: String, message: String)
}
