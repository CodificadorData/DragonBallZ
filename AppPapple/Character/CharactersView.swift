//
//  CharactersView.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import UIKit
import Kingfisher

class CharacterViewController: BaseViewController {
    
    var presenter: CharacterPresenter?
    
    lazy var titleNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = dragonBallModel.name
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var additionalDataOneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = dragonBallModel.gender
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var additionalDataTwoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = dragonBallModel.race
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var additionalDataThreeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = dragonBallModel.maxKi
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.text = dragonBallModel.description
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var characterImageView: UIImageView = {
        let image = UIImageView()
        guard let imageUrl = dragonBallModel.image else { return image }
        image.kf.setImage(with: URL(string: imageUrl))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
        
    var dragonBallModel: Item
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1)
        setupConstraints()
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Atrás",
            style: .plain,
            target: nil,
            action: #selector(didTapBackButton)
        )
        navigationItem.hidesBackButton = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isToolbarHidden = true
    }
    
    @objc func didTapBackButton() {
        print("Tap")
        presenter?.didTapBackButton()
    }
    
    init(dragonBallModel: Item) {
        self.dragonBallModel = dragonBallModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        viewContainer.addSubview(titleNameLabel)
        viewContainer.addSubview(additionalDataOneLabel)
        viewContainer.addSubview(additionalDataTwoLabel)
        viewContainer.addSubview(additionalDataThreeLabel)
        viewContainer.addSubview(descriptionLabel)
        viewContainer.addSubview(characterImageView)

        NSLayoutConstraint.activate([
            
            scrollHome.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            titleNameLabel.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 20),
            titleNameLabel.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            
            additionalDataOneLabel.topAnchor.constraint(equalTo: titleNameLabel.bottomAnchor, constant: 20),
            additionalDataOneLabel.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            
            additionalDataTwoLabel.topAnchor.constraint(equalTo: additionalDataOneLabel.bottomAnchor, constant: 20),
            additionalDataTwoLabel.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            
            additionalDataThreeLabel.topAnchor.constraint(equalTo: additionalDataTwoLabel.bottomAnchor, constant: 20),
            additionalDataThreeLabel.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: additionalDataThreeLabel.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.9),
            
            characterImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            characterImageView.heightAnchor.constraint(equalToConstant: 500),
            characterImageView.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor)
        ])
    }
                                    
}
