//
//  LoginInteractor.swift
//  AppPapple
//
//  Created by Christian Morante on 5/01/25.
//
import Alamofire
import SwiftKeychainWrapper

final class LoginInteractor: LoginInteractorProtocol {
    
    func validateUser(email: String, password: String,
                      dataUser: @escaping (_ dataJson: Result<ResponseUser, Error>) -> Void) {
        guard let endPoint = Bundle.main.object(forInfoDictionaryKey: "verifyUser_url") as? String else {
            return
        }
        let queryParams: [String: String] = [
            "email": email,
            "password": password
        ]
        AF.request(endPoint, method: .get, parameters: queryParams)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ResponseUser.self) {
                response in
                switch response.result {
                case .success(let result):
                    dataUser(.success(result))
                    KeychainWrapper.standard.set(result.accessToken, forKey: "accessToken")
                case .failure(let error):
                    dataUser(.failure(error))
                }
            }
    }
    
    func validateUserBiometrics(dataUser: @escaping (_ dataJson: Result<ResponseUser, Error>) -> Void){
        guard let endPoint = Bundle.main.object(forInfoDictionaryKey: "verifyUserBiometrics_url") as? String else { return }
        guard let refreshToken = KeychainWrapper.standard.string(forKey: "refreshToken")
            else { return }
        
        AF.request(endPoint, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ResponseUser.self) {
                response in
                switch response.result {
                case .success(let result):
                    KeychainWrapper.standard.set(result.accessToken, forKey: "accessToken")
                    KeychainWrapper.standard.set(result.refreshToken, forKey: "refreshToken")
                    dataUser(.success(result))
                case .failure(let error):
                    dataUser(.failure(error))
                }
            }
    }
    
    func consultBiometricsFlag() -> Bool {
        guard let biometricsActivationFlag = KeychainWrapper.standard.bool(forKey: "biometricsActivationFlag") else {
            return false
        }
        return biometricsActivationFlag
    }
}

protocol LoginInteractorProtocol: AnyObject {
    func validateUser(email: String, password: String,
                      dataUser: @escaping (_ dataJson: Result<ResponseUser, Error>) -> Void)
}
