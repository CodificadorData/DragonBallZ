//
//  RegisterInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 6/01/25.
//
import Foundation
import Alamofire

class RegisterInteractor {
    
    func registerUser(user: NewUserEntity) {
        let url = "http://localhost:3001/registerUserAppPapple" // URL de tu API
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer_mi_token_de_prueba"
            ]
        
        let parameters: [String: Any] = [
            "name": user.name,
            "surName": user.surname,
            "email": user.email,
            "password": user.password,
            "phoneNumber": user.phoneNumber
        ]

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    print("Respuesta recibida: \(data)")
                case .failure(let error):
                    print("Error al enviar datos: \(error.localizedDescription)")
                }
            }
    }
}
