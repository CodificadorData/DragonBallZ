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
    var view: CharacterViewProtocol?
    
    init(interactor: CharactersInteractor, router: CharactersRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func didTapBackButton() {
        router.goToHome()
    }
    
    func didTapStar(dragonBallModel: Item) {
        interactor.saveCharacter(dragonBallModel) { response in
            switch response {
            case .success(let success):
                self.view?.showMessage(title: success, message: "Guardado exitosamente!")
            case .failure(let error):
                self.view?.showMessage(title: "Ya es favorito!", message: ":)")
            }
        }
        
    }
    
    func checkFavoriteCharacter(id: Int) {
        interactor.checkFavoriteCharacter(id: id) { booleanResult in
            switch booleanResult {
            case .success(let resultCharacter):
                self.view?.checkFavoriteCharacter(isFavorite: resultCharacter.isFavorite)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
}

protocol CharacterPresenterProtocol: AnyObject {
    func didTapBackButton()
}

protocol CharacterViewProtocol: AnyObject {
    func checkFavoriteCharacter(isFavorite: Bool)
    func showMessage(title: String, message: String)
}
