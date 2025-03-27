//
//  HomeInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import Foundation
import Alamofire
import Kingfisher

class HomeInteractor {

    func requestDragonBall(url: String = "https://dragonball-api.com/api/characters", dataJson: @escaping (_ dataDragon: DragonBallEntity) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url).responseDecodable(of: DragonBallEntity.self) { response in
            switch response.result {
            case .success(let response):
                DispatchQueue.main.async {
                    dataJson(response)
                }
            case .failure(_):
                print("error")
            }
        }
    }
    
}
