//
//  ViewController.swift
//  ExampleBanner
//
//  Created by Christian Alexander Morante Santander on 27/12/23.
//

import UIKit

class ViewController: UIViewController {

            lazy var bannerButton: UIButton = {
                let button = UIButton()
                button.setTitle(">", for: .normal)
                return button
            }()
            
            lazy var bannerImage: UIImageView = {
                let image = UIImageView()
                image.image = UIImage(named: "goku")
                image.contentMode = .scaleToFill
                return image
            }()
            lazy var bannerDescription: UILabel = {
                let description = UILabel()
                description.text = "S/ 20.200 (TCEA de 10.2%)"
                description.textAlignment = .center
                description.textColor = .black
                description.font = UIFont.systemFont(ofSize: 12)
                return description
            }()
            lazy var bannerTittle: UILabel = {
                let tittle = UILabel()
                tittle.text = "Solicita tu Préstamo \npre aprobado de:"
                tittle.textAlignment = .center
                tittle.textColor = .black
                tittle.font = UIFont.systemFont(ofSize: 16)

                return tittle
            }()

            lazy var viewContainer: UIView = {
               let container = UIView()
                container.backgroundColor = .white
                return container
            }()

            lazy var bannerView: UIView = {
                let view = UIView()
                view.backgroundColor = .blue
                return view
            }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(viewContainer)
        viewContainer.addSubview(bannerView)
        bannerView.addSubview(bannerButton)
        bannerView.addSubview(bannerTittle)
        bannerView.addSubview(bannerDescription)
        bannerView.addSubview(bannerImage)
        setupBannerView()
        

    }

    func setupBannerView() {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerButton.translatesAutoresizingMaskIntoConstraints = false
        bannerTittle.translatesAutoresizingMaskIntoConstraints = false
        bannerDescription.translatesAutoresizingMaskIntoConstraints = false
        bannerImage.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            viewContainer.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            viewContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            viewContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bannerView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -50),
            bannerView.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            bannerView.widthAnchor.constraint(equalToConstant: 327),
            bannerView.heightAnchor.constraint(equalToConstant: 104),
            
            bannerButton.widthAnchor.constraint(equalToConstant: 20),
            bannerButton.heightAnchor.constraint(equalToConstant: 20),
            bannerButton.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor),
            bannerButton.rightAnchor.constraint(equalTo: bannerView.rightAnchor, constant: -10),
            
            bannerTittle.topAnchor.constraint(equalTo: bannerView.topAnchor, constant: 10),
            bannerTittle.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor),
            
            bannerDescription.topAnchor.constraint(equalTo: bannerTittle.topAnchor, constant: 70),
            bannerDescription.leftAnchor.constraint(equalTo: bannerView.leftAnchor, constant: 20),
            
            bannerImage.topAnchor.constraint(equalTo: bannerView.topAnchor, constant: 20),
            bannerImage.rightAnchor.constraint(equalTo: bannerView.rightAnchor, constant: -50),
            bannerImage.heightAnchor.constraint(equalToConstant: 80),
            bannerImage.widthAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    
}

