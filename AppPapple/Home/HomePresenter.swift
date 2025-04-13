//
//  HomePresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import UIKit

class HomePresenter {
    
    private let dragonBallInteractor: HomeInteractor
    var ui: DragonBallUI?
    var modelDragon: [Item] = []
    var page: String?
    
    init(homeInteractor: HomeInteractor) {
        self.dragonBallInteractor = HomeInteractor()
    }
        
    func bringData(){
        dragonBallInteractor.requestDragonBall(url: page, dataJson: { dataDragon in
            switch dataDragon {
            case .success(let response):
                self.modelDragon.append(contentsOf: response.items)
                self.ui?.updateDragonBall(dragonBallList: self.modelDragon)
                self.page = response.links.next
            case .failure(let error):
                print(error)
            }
        })
    }

        
}
protocol DragonBallUI: AnyObject {
    func updateDragonBall(dragonBallList: [Item])
}
