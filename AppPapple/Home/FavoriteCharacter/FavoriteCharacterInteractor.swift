//
//  FavoriteCharacterInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 25/08/25.
//

import CoreData

class FavoriteCharacterInteractor {
    
    let coreDataStack = CoreDataStack.shared
    
    func fetchCharacters(dataFavoriteCharacter: @escaping (_ dataDragon: Result<[FavoriteCharacter], Error>) -> Void){
        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        do {
            let result = try coreDataStack.context.fetch(request)
            dataFavoriteCharacter(.success(result))
        } catch {
            dataFavoriteCharacter(.failure("error" as! Error))
        }
    }
    
}
