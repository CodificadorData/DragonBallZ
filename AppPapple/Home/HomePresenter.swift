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
    var page: String = ""
    init(homeInteractor: HomeInteractor) {
        self.dragonBallInteractor = HomeInteractor()
    }
    
    func bringData(bool: Bool = false){
        if bool {
            dragonBallInteractor.requestDragonBall(url: page, dataJson: { dataDragon in
                self.modelDragon.append(contentsOf: dataDragon.items)
                self.ui?.updateDragonBall(dragonBallList: self.modelDragon)
                self.page = dataDragon.links.next
            })
        } else {
            dragonBallInteractor.requestDragonBall(dataJson: { dataDragon in
                self.modelDragon.append(contentsOf: dataDragon.items)
                self.ui?.updateDragonBall(dragonBallList: self.modelDragon)
                self.page = dataDragon.links.next
            })

        }
    }
        
}
protocol DragonBallUI: AnyObject {
    func updateDragonBall(dragonBallList: [Item])
}
