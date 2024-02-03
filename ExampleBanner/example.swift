////
////  bannerView.swift
////  ExampleBanner
////
////  Created by Christian Alexander Morante Santander on 27/12/23.
////
//import Foundation
//import UIKit
//import Alamofire
//
//struct jsonStruct: Decodable {
//    
//    let message: String
//    let link: String
//    let iosImageUrl: String
//    let description: String
//    let background: String
//}
//
//class example: ViewController {
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = UIColor.red
//        
//        let postURL = "www.adobe.com"
//        let parameters: Parameters = [
//            "clave1": "valor1",
//            "clave2": "valor2"
//        ]
//        
//        func requestAdobe() {
//            AF.request(postURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
//                    switch response.result {
//                    case .success(let value):
//                        // Manejar la respuesta exitosa
//                        print("Respuesta: \(value)")
//                    case .failure(let error):
//                        // Manejar el error
//                        print("Error: \(error)")
//                                            }
//                                                                                                                }
//        }
//        
//        lazy var bannerView: UIView = {
//            var view = UIView()
//            view.backgroundColor = UIColor(red: 0, green: 48, blue: 179, alpha: 1)
//            return view
//        }()
//        
//        lazy var bannerButton: UIButton = {
//            var button = UIButton()
//            button.setTitle(">", for: .normal)
//            return button
//        }()
//        
//        lazy var bannerImage: UIImage = {
//            var image = UIImage()
//            return image
//        }()
//        lazy var bannerDescription: UILabel = {
//            var description = UILabel()
//            description.setValue("S/ 20.200 (TCEA de 10.2%)", forKey: "TCEA")
//            return description
//        }()
//        lazy var bannerTittle: UILabel = {
//            var tittle = UILabel()
//            tittle.setValue("Solicita tu Préstamo \npre aprobado de:", forKey: "tittle")
//            return tittle
//        }()
//        
//        func setupBannerView() {
//            bannerView.translatesAutoresizingMaskIntoConstraints = false  // Importante para trabajar con restricciones programáticamente
//            
//            NSLayoutConstraint.activate([
//                bannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 222),
//                bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
//                bannerView.widthAnchor.constraint(equalToConstant: 327),
//                bannerView.heightAnchor.constraint(equalToConstant: 104)
//             ])
//        }
//        
//        view.addSubview(bannerView)
//        
//        
//        
//        
//    }
//    
//
//}
