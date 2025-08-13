//
//  SongsListView.swift
//  AppPapple
//
//  Created by Christian Morante on 8/08/25.
//

import UIKit
import Kingfisher

class SongsListView: UIViewController {
    
    var songList: [SongsEntity]
    
    lazy var titleSongsList: UILabel = {
        let label = UILabel()
        label.text = "Songs"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var coverSongs: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var tableSongs: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SongsTableViewCell.self, forCellReuseIdentifier: SongsTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(songsList: [SongsEntity]) {
        self.songList = songsList
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(coverSongs)
        view.addSubview(titleSongsList)
        view.addSubview(tableSongs)
        
        NSLayoutConstraint.activate([
            coverSongs.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            coverSongs.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            coverSongs.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            coverSongs.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            titleSongsList.topAnchor.constraint(equalTo: coverSongs.bottomAnchor, constant: 10),
            titleSongsList.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableSongs.topAnchor.constraint(equalTo: titleSongsList.bottomAnchor, constant: 10),
            tableSongs.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableSongs.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableSongs.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        view.backgroundColor = .systemOrange
    }
    
}

extension SongsListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongsTableViewCell.identifier, for: indexPath) as? SongsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(song: songList[indexPath.row], songsCant: songList.count)
        coverSongs.kf.setImage(with: URL(string: (songList.first?.songCover)!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height * 0.15
    }

    
}
