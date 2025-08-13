//
//  ShortsCollectionViewCell.swift
//  AppPapple
//
//  Created by Christian Morante on 5/08/25.
//
import UIKit
import Kingfisher

class ShortsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ShortsCollectionViewCell"
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var imageCell: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUi()
    }
    
    func setupUi() {
        self.addSubview(imageCell)
        self.addSubview(descriptionLabel)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        NSLayoutConstraint.activate([

            imageCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            imageCell.heightAnchor.constraint(equalToConstant: 100),
            
            descriptionLabel.topAnchor.constraint(equalTo: imageCell.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        backgroundColor = .brown
    }
    
    func configure(description: String, imageUrl: URL) {
        self.descriptionLabel.text = description
        self.imageCell.kf.setImage(with: imageUrl)
    }
    
}
