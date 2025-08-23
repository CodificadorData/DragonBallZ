//
//  CharactersPresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import UIKit

final class CharacterPresenter: CharacterPresenterProtocol {
    
    private var interactor: CharactersInteractor
    var router: CharactersRouter
    
    init(interactor: CharactersInteractor, router: CharactersRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func didTapBackButton() {
        router.goToHome()
    }
    
}

protocol CharacterPresenterProtocol: AnyObject {
    func didTapBackButton()
}
