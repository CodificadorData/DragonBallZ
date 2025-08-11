//
//  StoreInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 10/08/25.
//

import Alamofire

class StoreInteractor {
    
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
