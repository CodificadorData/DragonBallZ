//
//  FavoriteCharacterPresenter.swift
//  AppPapple
//
//  Created by Christian Morante on 25/08/25.
//

class FavoriteCharacterPresenter {
    private let interactor: FavoriteCharacterInteractor
    var view: FavoriteCharacterViewProtocol?
    
    init(interactor: FavoriteCharacterInteractor) {
        self.interactor = interactor
    }
    
    func fetchCharacters() {
        interactor.fetchCharacters { dataDragon in
            switch dataDragon {
            case .success(let dataDragon):
                self.view?.fetchResults(result: dataDragon)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

protocol FavoriteCharacterViewProtocol: AnyObject {
    func fetchResults(result: [FavoriteCharacter])
}
