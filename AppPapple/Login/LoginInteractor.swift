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
        
        let url = "http://localhost:3001/verifyUserAppPaple/v1"

        let queryParams: [String: String] = [
            "email": email,
            "password": password
        ]
        
        AF.request(url, method: .get, parameters: queryParams)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ResponseUser.self) {
            response in
            switch response.result {
                case .success(let result):
                        dataUser(.success(result))
                        KeychainWrapper.standard.set(result.token, forKey: "authToken")
                        print("validateUser \(result)")
                case .failure(let error):
                    print("error validateUser \(error)")
                    dataUser(.failure(error))
            }
        }
    }
}
