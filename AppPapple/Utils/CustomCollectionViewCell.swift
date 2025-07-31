//
//  CustomCollectionViewCell.swift
//  AppPapple
//
//  Created by Christian Morante on 30/07/25.
//
import UIKit
import Kingfisher

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let imageProduct: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 7/255.0, green: 32/255.0, blue: 131/255.0, alpha: 1)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(imageProduct)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5),
            
            imageProduct.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            imageProduct.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageProduct.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            imageProduct.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with text: String, url: URL) {
        label.text = text
        imageProduct.kf.setImage(with: url)
    }
}
