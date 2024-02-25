//
//  HomeInteractor.swift
//  ExampleBanner
//
//  Created by Christian Morante on 18/02/24.
//

import Foundation
import Alamofire

class DragonBallInteractor {

func requestDragonBall(){
    AF.request("https://dragonball-api.com/api/characters").responseJSON { response in
        switch response.result {
        case .success(let value):
            print("Respuesta exitosa: \(value)")
            
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value)
                    let decoder = JSONDecoder()
                    let myData = try decoder.decode(Character.self, from: jsonData)
                    print("Datos decodificados: \(myData)")
                } catch {
                    print("Error al decodificar: \(error)")
                }
        case .failure(let error):
            print("Error: \(error)")
            // Aquí puedes manejar el error
        }
    }
}

}
