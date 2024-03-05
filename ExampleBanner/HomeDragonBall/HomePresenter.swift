//
//  HomePresenter.swift
//  ExampleBanner
//
//  Created by Christian Morante on 18/02/24.
//

import Foundation

class DragonBallPresenter {
    
    private let dragonBallInteractor: DragonBallInteractor
    var ui: DragonBallUI?
    var modelDragon: [Item] = []
    init(dragonBallInteractor: DragonBallInteractor) {
        self.dragonBallInteractor = dragonBallInteractor
    }
    
    func bringData(){
        dragonBallInteractor.requestDragonBall(dataJson: { dataDragon in
            self.modelDragon = dataDragon.items
            self.ui?.updateDragonBall(dragonBallList: self.modelDragon)
        })
    
    }
}

protocol DragonBallUI: AnyObject {
    func updateDragonBall(dragonBallList: [Item])
}
