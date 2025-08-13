//
//  MusicUIView.swift
//  AppPapple
//
//  Created by Christian Morante on 3/08/25.
//

import UIKit
import Kingfisher

class MusicUIView: UIView {
    
    var onPlayButtonTap: (() -> Void)?

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var playImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "playIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(listSongs))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func listSongs() {
        onPlayButtonTap?()
    }
    
    func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)
        addSubview(playImageView)
        bringSubviewToFront(playImageView)

        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
            playImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            playImageView.heightAnchor.constraint(equalToConstant: 30),
            playImageView.widthAnchor.constraint(equalToConstant: 30)
            
            ])
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        }
    
    func configure(backgroundImage: String,music: SongsEntity, count: Int) {
        guard let cover = URL(string: music.songCover),
              let background = URL(string: backgroundImage) else { return }
        
        self.backgroundImageView.kf.setImage(with: background)
        self.imageView.kf.setImage(with: cover)
        self.titleLabel.text = music.songTitle
        self.countLabel.text = "Hay \(count) canciones"
    }
    
}
