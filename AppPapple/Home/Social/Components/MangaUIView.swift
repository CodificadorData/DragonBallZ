//
//  MangaUIView.swift
//  AppPapple
//
//  Created by Christian Morante on 3/08/25.
//

import UIKit
import Kingfisher

class MangaUIView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var mangaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(mangaImageView)
        self.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            
            mangaImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            mangaImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            mangaImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            mangaImageView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: mangaImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
        ])
        
        self.backgroundColor = .brown
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(image: URL, title: String) {
        self.titleLabel.text = title
        self.mangaImageView.kf.setImage(with: image)
    }
}
