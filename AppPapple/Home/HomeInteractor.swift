//
//  HomeInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import Alamofire
import Kingfisher

final class HomeInteractor {
    
    func requestDragonBall(url: String?, dataJson: @escaping (_ dataDragon: Result<DragonBallEntity, Error>) -> Void) {
        let endPoint = Bundle.main.object(forInfoDictionaryKey: "db_url") as? String ?? ""
        let urlFinal = url ?? endPoint
        AF.request(urlFinal, method: .get, encoding: JSONEncoding.default)
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
    
}
