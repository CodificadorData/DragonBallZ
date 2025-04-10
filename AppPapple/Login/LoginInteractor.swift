//
//  LoginInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 5/01/25.
//
import Foundation
import Alamofire

class LoginInteractor {
    
    
    func validateUser(email: String, password: String,
                      dataUser: @escaping (_ dataJson: Result<ResponseUser, Error>) -> Void) {
        
        guard let url = URL(string: "http://localhost:3001/verifyUserAppPaple/v1") else { return }
        
        let queryParams: [String: String] = [
            "email": email,
            "password": password
        ]
        
        AF.request(url, method: .get, parameters: queryParams).responseDecodable(of: ResponseUser.self) {
            response in
            switch response.result {
            case .success(let response):
                DispatchQueue.main.async {
                    dataUser(.success(response))
                }
            case .failure(let error):
                print("error \(error)")
                dataUser(.failure(error))
            }
        }
    }
}
