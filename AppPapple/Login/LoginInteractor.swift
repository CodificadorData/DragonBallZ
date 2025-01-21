//
//  LoginInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 5/01/25.
//
import Foundation
import Alamofire

class LoginInteractor {
    
    
    func validateUser(email: String, password: String) throws -> UserEntity {
        do {
            let usuario = try JSONDecoder().decode(ResponseUser.self, from: UserMock.user)
            return usuario.users
        } catch {
            print("Error al decodificar JSON: \(error)")
            throw UserError.invalidData
        }
    }
}
