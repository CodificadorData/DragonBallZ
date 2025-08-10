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
    }
    
    @objc func playSong() {
        print("play")
    }
    
    func setupUI() {
        addSubview(imageCoverSong)
        addSubview(titleSong)
        addSubview(artistSong)
        addSubview(playImageView)
        
        NSLayoutConstraint.activate([
            imageCoverSong.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageCoverSong.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageCoverSong.widthAnchor.constraint(equalToConstant: 50),
            imageCoverSong.heightAnchor.constraint(equalToConstant: 50),
            
            titleSong.leftAnchor.constraint(equalTo: imageCoverSong.trailingAnchor, constant: 10),
            titleSong.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            artistSong.leftAnchor.constraint(equalTo: imageCoverSong.trailingAnchor, constant: 10),
            artistSong.topAnchor.constraint(equalTo: titleSong.bottomAnchor, constant: 5),
            
            playImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            playImageView.widthAnchor.constraint(equalToConstant: 30),
            playImageView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func cofigure(song: SongsEntity, songsCant: Int) {
        guard let cover = URL(string: song.songCover) else { return }
        imageCoverSong.kf.setImage(with: cover)
        titleSong.text = song.songTitle
        artistSong.text = song.songArtist
    }
}
