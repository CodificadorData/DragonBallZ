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
        
        let url = "https://jsonplaceholder.typicode.com/users/1"
        
        guard let url = URL(string: url) else { return }

        AF.request(url).responseDecodable(of: NewUserEntity.self) {
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
