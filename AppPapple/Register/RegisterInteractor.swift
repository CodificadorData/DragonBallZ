//
//  RegisterInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 6/01/25.
//

import Alamofire

class RegisterInteractor {
    
    func registerUser(user: NewUserEntity, dataJson: @escaping (Result<ResponseRegister, Error>) -> Void) {
        let url = "http://localhost:3001/registerUserAppPapple"
            
        let parameters: [String: Any?] = [
            "name": user.name,
            "surName": user.surName,
            "email": user.email,
            "password": user.password,
            "phoneNumber": user.phoneNumber,
            "imageProfile": user.imageProfile
        ]

        AF.request(url, method: .post, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ResponseRegister.self){
            response in
                switch response.result {
                case .success(let data):
                    print("registerUser: \(data)")
                    dataJson(.success(data))
                case .failure(let error):
                    print("Error registerUser: \(error)")
                    dataJson(.failure(error))
                }
            }
    }
}
