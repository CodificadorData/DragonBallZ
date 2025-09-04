//
//  FavoriteCharacterViewCell.swift
//  AppPapple
//
//  Created by Christian Morante on 25/08/25.
//

import UIKit
import Kingfisher

class FavoriteCharacterViewCell: UICollectionViewCell {
    
    static let reusableIdentifier = "FavoriteCharacterViewCell"
    var url: String?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var linkDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        let text = "Enlace para detalles"
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 0, length: text.count))

        label.attributedText = attributedString
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openLink))
        label.addGestureRecognizer(tapGesture)
        return label
    }()

    lazy var characterImageView: UIImageView = {
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
        setupUI()
    }

    @objc func openLink() {
        if let url = URL(string: url!) {
            UIApplication.shared.open(url)
        }
    }
    
    func setupUI() {
        self.addSubview(titleLabel)
        self.addSubview(linkDetailLabel)
        self.addSubview(characterImageView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            characterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            characterImageView.widthAnchor.constraint(equalToConstant: 60),
            characterImageView.heightAnchor.constraint(equalToConstant: 60),
            
            linkDetailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            linkDetailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        ])
        backgroundColor = .green
    }
    
    func configure(character: FavoriteCharacter) {
        titleLabel.text = character.name
        characterImageView.kf.setImage(with: URL(string: character.image!)!)
        url = character.sourceLink
    }
}
