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
        let urlFinal = url ?? "https://dragonball-api.com/api/characters"
        AF.request(urlFinal, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: DragonBallEntity.self) { response in
            switch response.result {
            case .success(let response):
                DispatchQueue.main.async {
                    dataJson(.success(response))
                }
            case .failure(let error):
                dataJson(.failure(error))
            }
        }
    }
    
}
