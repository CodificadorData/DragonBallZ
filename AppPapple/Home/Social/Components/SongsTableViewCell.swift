//
//  SongsTableViewCell.swift
//  AppPapple
//
//  Created by Christian Morante on 8/08/25.
//

import UIKit
import Kingfisher

class SongsTableViewCell: UITableViewCell {
    
    static let identifier = "SongsTableViewCell"
    private var url: String?
    var onPlayTapped: (() -> Bool)?

    lazy var imageCoverSong: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleSong: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var artistSong: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(playSong))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        contentView.backgroundColor = .orange
    }
    
    @objc func playSong() {
        if onPlayTapped!() {
            UIView.transition(with: playImageView,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                self.playImageView.image = UIImage(named: "pauseIcon")
            }, completion: nil)
        } else {
            UIView.transition(with: playImageView,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: {
                self.playImageView.image = UIImage(named: "playIcon")
            }, completion: nil)
        }
    }
    
    func setupUI() {
        contentView.addSubview(imageCoverSong)
        contentView.addSubview(titleSong)
        contentView.addSubview(artistSong)
        contentView.addSubview(playImageView)
        
        NSLayoutConstraint.activate([
            imageCoverSong.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageCoverSong.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageCoverSong.widthAnchor.constraint(equalToConstant: 50),
            imageCoverSong.heightAnchor.constraint(equalToConstant: 50),
            
            titleSong.leadingAnchor.constraint(equalTo: imageCoverSong.trailingAnchor, constant: 10),
            titleSong.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            artistSong.leadingAnchor.constraint(equalTo: imageCoverSong.trailingAnchor, constant: 20),
            artistSong.topAnchor.constraint(equalTo: titleSong.bottomAnchor, constant: 3),
            
            playImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playImageView.widthAnchor.constraint(equalToConstant: 30),
            playImageView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func configure(song: SongsEntity, songsCant: Int) {
        guard let cover = URL(string: song.songCover) else { return }
        imageCoverSong.kf.setImage(with: cover)
        titleSong.text = song.songTitle
        artistSong.text = song.songArtist
        url = song.songLink
    }
}
