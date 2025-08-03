//
//  SocialCollectionViewCell.swift
//  AppPapple
//
//  Created by Christian Morante on 31/07/25.
//
import UIKit
import Kingfisher

class SocialCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SocialCollectionViewCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageCell: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUi()
        backgroundColor = .brown
    }
    
    func setupUi() {
        backgroundColor = .darkGray
        contentView.addSubview(imageCell)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: 5),
            
            imageCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageCell.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            imageCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageCell.trailingAnchor, constant: -5),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    func configure(title: String, description: String, url: URL) {
        titleLabel.text = title
        descriptionLabel.text = description
        imageCell.kf.setImage(with: url)
    }

}

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
