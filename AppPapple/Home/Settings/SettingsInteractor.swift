//
//  SettingsInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 10/08/25.
//
import Alamofire

final class SettingsInteractor {
    
    func fetchUserData(authorizationToken: String, dataUser: @escaping (_ dataJson: Result<NewUserEntity, Error>) -> Void) {
        let endPoint = Bundle.main.object(forInfoDictionaryKey: "user_url") as? String
        guard let url = endPoint else { return }
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
                    dataUser(.success(response))
                case .failure(let error):
                    dataUser(.failure(error))
                }
            }
    }
    
    func updateUserData(user: NewUserEntity, authorizationToken: String
                        , dataUser: @escaping (_ dataJson: Result<NewUserEntity, Error>) -> Void ){
        let endPoint = Bundle.main.object(forInfoDictionaryKey: "updateUser_url") as? String
        guard let url = endPoint else { return }
        let queryParams: [String: String?] = [
            "name": user.name,
            "surName": user.surName,
            "phoneNumber": user.phoneNumber,
            "email": user.email,
            "password": user.password,
            "imageProfile": user.imageProfile
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": authorizationToken
        ]
        AF.request(url, method: .get, parameters: queryParams, headers: headers).responseDecodable(of: NewUserEntity.self) { response in
            switch response.result {
            case .success(let response):
                dataUser(.success(response))
            case .failure(let error):
                dataUser(.failure(error))
            }
        }
    }

}
