//
//  CharactersView.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import UIKit
import Kingfisher

class CharacterViewController: UIViewController {
    
    var presenter: CharacterPresenter?
    
    lazy var titleNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = dragonBallModel.name
        return label
    }()
    
    lazy var additionalDataOneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = dragonBallModel.gender
        return label
    }()
    
    lazy var additionalDataTwoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = dragonBallModel.race
        return label
    }()

    lazy var additionalDataThreeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = dragonBallModel.maxKi
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.text = dragonBallModel.description
        return label
    }()

    lazy var characterImageView: UIImageView = {
        let image = UIImageView()
        guard let imageUrl = dragonBallModel.image else { return image }
        image.kf.setImage(with: URL(string: imageUrl))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1)
        scroll.addSubview(contentView)
        return scroll
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1)
        view.addSubview(characterImageView)
        view.addSubview(additionalDataOneLabel)
        view.addSubview(additionalDataTwoLabel)
        view.addSubview(additionalDataThreeLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(titleNameLabel)
        return view
    }()
    
    var dragonBallModel: Item
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1)
        view.addSubview(scrollView)
        setupConstraints()
        navigationController?.isToolbarHidden = true
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Atrás",
            style: .plain,
            target: nil,
            action: #selector(didTapBackButton)
        )
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
        titleNameLabel.translatesAutoresizingMaskIntoConstraints = false
        additionalDataOneLabel.translatesAutoresizingMaskIntoConstraints = false
        additionalDataTwoLabel.translatesAutoresizingMaskIntoConstraints = false
        additionalDataThreeLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1300),

            
            titleNameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            titleNameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            additionalDataOneLabel.topAnchor.constraint(equalTo: titleNameLabel.bottomAnchor, constant: 20),
            additionalDataOneLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            additionalDataTwoLabel.topAnchor.constraint(equalTo: additionalDataOneLabel.bottomAnchor, constant: 20),
            additionalDataTwoLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            additionalDataThreeLabel.topAnchor.constraint(equalTo: additionalDataTwoLabel.bottomAnchor, constant: 20),
            additionalDataThreeLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: additionalDataThreeLabel.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            characterImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            characterImageView.heightAnchor.constraint(equalToConstant: 500),
            characterImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
                                    
}
