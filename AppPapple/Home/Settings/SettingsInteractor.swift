//
//  SettingsInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 7/04/25.
//

import Alamofire

class SettingsInteractor {
    
    func fetchUserData(authorizationToken: String, dataUser: @escaping (_ dataJson: NewUserEntity) -> Void) {
        guard let url = URL(string: "http://localhost:3001/fetchUserAppPapple") else { return }
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": authorizationToken
        ]
        AF.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: NewUserEntity.self) {
            response in
            switch response.result {
            case .success(let response):
                DispatchQueue.main.async {
                    dataUser(response)
                    print("fetchUserData")
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
    
    func updateUserData(name: String, surName: String, phoneNumber: String,
                        email: String, authorizationToken: String, imageProfile: String,
                        password: String, dataUser: @escaping (_ dataJson: Result<NewUserEntity, Error>) -> Void ){
        guard let url = URL(string: "http://localhost:3001/updateUserAppPapple") else { return }
        let queryParams: [String: String] = [
            "name": name,
            "surName": surName,
            "phoneNumber": phoneNumber,
            "email": email,
            "password": password,
            "imageProfile": imageProfile
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": authorizationToken
        ]
        AF.request(url, method: .get, parameters: queryParams, headers: headers).responseDecodable(of: NewUserEntity.self) { response in
            switch response.result {
            case .success(let response):
                DispatchQueue.main.async {
                    dataUser(.success(response))
                    print("updateUserData")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    dataUser(.failure(error))
                    print("updateUserData error \(error)")
                }
            }
        }
    }
    
}
