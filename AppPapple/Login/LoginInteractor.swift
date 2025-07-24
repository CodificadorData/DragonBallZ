//
//  LoginInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 5/01/25.
//
import Alamofire
import SwiftKeychainWrapper

class LoginInteractor {
    
    
    func validateUser(email: String, password: String,
                      dataUser: @escaping (_ dataJson: Result<ResponseUser, Error>) -> Void) {
        
        guard let endPoint = Bundle.main.object(forInfoDictionaryKey: "verifyUser_url") as? String else {
            return
        }

        let queryParams: [String: String] = [
            "email": email,
            "password": password
        ]
        
        AF.request(endPoint, method: .get, parameters: queryParams)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ResponseUser.self) {
            response in
            switch response.result {
                case .success(let result):
                        dataUser(.success(result))
                        KeychainWrapper.standard.set(result.token, forKey: "authToken")
                case .failure(let error):
                    dataUser(.failure(error))
            }
        }
    }
}
