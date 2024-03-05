//
//  HomeInteractor.swift
//  ExampleBanner
//
//  Created by Christian Morante on 18/02/24.
//

import Foundation
import Alamofire

class DragonBallInteractor {
    
    //    func requestDragonBall() -> DragonBallEntity {
    //        var data: DragonBallEntity?
    //
    //        AF.request("https://dragonball-api.com/api/characters").responseDecodable(of: DragonBallEntity.self) { response in
    //            switch response.result {
    //            case .success(let result):
    //                data = response.value
    //            case .failure(let error):
    //                print("Error: \(error)")
    //            }
    //        }
    //
    //
    //        return data!
    //    }
    
    
    func requestDragonBall(dataJson: @escaping (_ dataDragon: DragonBallEntity) -> Void) {
        
         AF.request("https://dragonball-api.com/api/characters").response { response in
            switch response.result {
            case .success(let resu):
                let datas = try? JSONDecoder().decode(DragonBallEntity.self, from: resu!)
                dataJson(datas!)
            case .failure(_):
                print("error")
            }
        }

    }
}
