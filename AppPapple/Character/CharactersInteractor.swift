//
//  CharactersInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import Foundation
import CoreData

final class CharactersInteractor: CharactersInteractorProtocol {
    
    private let coreData = CoreDataStack.shared

    func saveCharacter(_ character: Item, response: @escaping (Result<String,Error>) -> Void) {
        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", character.id)
        do {
            if let _ = try coreData.context.fetch(request).first {
                response(.failure(CoreDataError.alreadyExists))
            } else {
                let favoriteCharacter = FavoriteCharacter(context: coreData.context)
                favoriteCharacter.id = Int64(character.id)
                favoriteCharacter.name = character.name
                favoriteCharacter.image = character.image
                favoriteCharacter.isFavorite = true
                favoriteCharacter.sourceLink = character.description
                coreData.saveContext()
                response(.success("Guardado!"))
            }
        } catch {
            response(.failure(CoreDataError.queryError))
        }
    }

    func checkFavoriteCharacter(id :Int, queryResult: @escaping (_ booleanResult: Result<FavoriteCharacter, Error>) -> Void) {
        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        do {
            if let result = try coreData.context.fetch(request).first {
                queryResult(.success(result))
            } else {
                queryResult(.failure(CoreDataError.notFound))
            }
        } catch {
            queryResult(.failure(error))
        }
    }
}

protocol CharactersInteractorProtocol: AnyObject {
    func saveCharacter(_ character: Item, response: @escaping (Result<String,Error>) -> Void)
}

enum CoreDataError: Error {
    case notFound
    case alreadyExists
    case queryError
}
