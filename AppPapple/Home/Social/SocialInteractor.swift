//
//  SocialInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 10/08/25.
//

import Alamofire

final class SocialInteractor: SocialInteractorProtocol {
    
    func fetchNews(dataResponse: @escaping (_ dataJson: Result<NewsEntity, Error>) -> Void) {
        let endPoint = Bundle.main.object(forInfoDictionaryKey: "news_url") as? String ?? ""
        AF.request(endPoint, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: NewsEntity.self) { response in
                switch response.result {
                    case .success(let news):
                        dataResponse(.success(news))
                    case .failure(let error):
                        dataResponse(.failure(error))
                }
            }
    }
    
    func fetchShorts(dataResponse: @escaping (_ dataJson: Result<ShortsEntity,Error>) -> Void) {
        let endPoint = Bundle.main.infoDictionary?["shorts_url"] as? String ?? ""
        AF.request(endPoint, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ShortsEntity.self) { response in
                switch response.result {
                    case .success(let shorts):
                        dataResponse(.success(shorts))
                    case .failure(let error):
                        dataResponse(.failure(error))
                }
            }
    }
    
    func fetchMultimedia(dataJson: @escaping (_ dataResponse: Result<MultimediaEntity, Error>) -> Void) {
        let endPoint = Bundle.main.infoDictionary?["multimedia_url"] as? String ?? ""
        AF.request(endPoint, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MultimediaEntity.self) { response in
                switch response.result {
                case .success(let response):
                    dataJson(.success(response))
                case .failure(let error):
                    dataJson(.failure(error))
                }
            }
    }

}

protocol SocialInteractorProtocol: AnyObject {
    func fetchNews(dataResponse: @escaping (_ dataJson: Result<NewsEntity, Error>) -> Void)
    func fetchShorts(dataResponse: @escaping (_ dataJson: Result<ShortsEntity,Error>) -> Void)
    func fetchMultimedia(dataJson: @escaping (_ dataResponse: Result<MultimediaEntity, Error>) -> Void)
}
