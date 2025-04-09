//
//  SettingsInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 7/04/25.
//

import Alamofire
import Foundation

class SettingsInteractor {
    
    func fetchUserData(dataUser: @escaping (_ dataJson: NewUserEntity) -> Void) {
        
        let url = "http://localhost:3001/fetchUserAppPapple"
        
        guard let url = URL(string: url) else { return }

        let queryParams: [String: Int] = [
            "email": 123,
            "password": 123
        ]

        AF.request(url, method: .get, parameters: queryParams).responseDecodable(of: NewUserEntity.self) {
            response in
            switch response.result {
            case .success(let response):
                DispatchQueue.main.async {
                    dataUser(response)
                }
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
}
