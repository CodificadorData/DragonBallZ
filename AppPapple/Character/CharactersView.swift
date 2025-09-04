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
    var dragonBallModel: Item

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
    
    lazy var starImageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "starIcon")?.withRenderingMode(.alwaysTemplate)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappableStar))
        image.addGestureRecognizer(tapGesture)
        return image
    }()
                
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1)
        setupConstraints()
        setupNavigationBar()
        presenter?.checkFavoriteCharacter(id: dragonBallModel.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isToolbarHidden = true
    }
    
    override func setupNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Atrás",
            style: .plain,
            target: nil,
            action: #selector(didTapBackButton)
        )
        navigationItem.hidesBackButton = false

    }
    
    @objc func tappableStar() {
        presenter?.didTapStar(dragonBallModel: dragonBallModel)
        starImageView.tintColor = .green
    }
    
    @objc func didTapBackButton() {
        presenter?.didTapBackButton()
        starImageView.tintColor = .clear
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
        viewContainer.addSubview(starImageView)

        NSLayoutConstraint.activate([
            
            scrollHome.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            titleNameLabel.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 20),
            titleNameLabel.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            
            starImageView.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 20),
            starImageView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -20),
            starImageView.heightAnchor.constraint(equalToConstant: 20),
            starImageView.widthAnchor.constraint(equalToConstant: 20),
            
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

extension CharacterViewController: CharacterViewProtocol {
    func showMessage(title: String, message: String) {
        self.showErrorPopUp(title: title, message: message)
    }
    
    func checkFavoriteCharacter(isFavorite: Bool) {
        if isFavorite {
            starImageView.tintColor = .green
        } else {
//            starImageView.tintColor = .clear
        }
    }

}
