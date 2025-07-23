//
//  HomeInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import Alamofire
import Kingfisher

class HomeInteractor {

    func requestDragonBall(url: String?, dataJson: @escaping (_ dataDragon: Result<DragonBallEntity, Error>) -> Void) {
        let endPoint = Bundle.main.object(forInfoDictionaryKey: "db_url") as? String ?? ""
        let urlFinal = url ?? endPoint
        AF.request(urlFinal, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: DragonBallEntity.self) { response in
            switch response.result {
            case .success(let response):
                    dataJson(.success(response))
            case .failure(let error):
                dataJson(.failure(error))
            }
        }
    }
    
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
                    print("updateUserData")
            case .failure(let error):
                    dataUser(.failure(error))
                    print("updateUserData error \(error)")
            }
        }
    }
    
    func fetchProducts(url: String?, dataResponse: @escaping (_ dataJson: Result<ProductEntity, Error>) -> Void) {
        let endPoint = Bundle.main.object(forInfoDictionaryKey: "product_url") as? String ?? ""
        let url = url ?? endPoint
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ProductEntity.self) { response in
                switch response.result {
            case .success(let characters):
                    dataResponse(.success(characters))
            case .failure(let error):
                dataResponse(.failure(error))
            }
        }
    }

}
