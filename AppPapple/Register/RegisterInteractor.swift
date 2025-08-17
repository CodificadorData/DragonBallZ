//
//  RegisterInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 6/01/25.
//

import Alamofire

final class RegisterInteractor: RegisterInteractorProtocol {
    
    func registerUser(user: NewUserEntity, dataJson: @escaping (Result<ResponseRegister, Error>) -> Void) {
        guard let endPoint = Bundle.main.object(forInfoDictionaryKey: "user_url") as? String else {
            return
        }
        
        let parameters: [String: Any?] = [
            "name": user.name,
            "surName": user.surName,
            "email": user.email,
            "password": user.password,
            "phoneNumber": user.phoneNumber,
            "imageProfile": user.imageProfile
        ]
        
        AF.request(endPoint, method: .post, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ResponseRegister.self){
                response in
                switch response.result {
                case .success(let data):
                    dataJson(.success(data))
                case .failure(let error):
                    dataJson(.failure(error))
                }
            }
    }
}

protocol RegisterInteractorProtocol: AnyObject {
    func registerUser(user: NewUserEntity, dataJson: @escaping (Result<ResponseRegister, Error>) -> Void)
}
