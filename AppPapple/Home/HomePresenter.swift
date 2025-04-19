//
//  HomePresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import UIKit

class HomePresenter {
    
    private let homeInteractor: HomeInteractor
    var view: HomeViewProtocol?
    var modelDragon: [Item] = []
    var page: String?
    
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

        
}
protocol HomeViewProtocol: AnyObject {
    func updateDragonBall(dragonBallList: [Item])
}
