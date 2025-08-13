//
//  AdditionalView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//

import UIKit

class SocialViewController: BaseViewController {
    
    var presenter: SocialPresenter?
    private var timer: Timer?
    private var currentIndex = 0
    var firtsMangaView = MangaUIView()
    var lastMangaView = MangaUIView()
    var musicView = MusicUIView()

    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.textColor = .white
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 18)
        title.text = "Social"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
        
    lazy var newsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1)
        collection.dataSource = self
        collection.delegate = self
        collection.register(SocialCollectionViewCell.self, forCellWithReuseIdentifier: SocialCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.layer.cornerRadius = 8
        collection.clipsToBounds = true
        collection.isPagingEnabled = true
        return collection
    }()
    
    lazy var multimediaLabel: UILabel = {
       let label = UILabel()
        label.text = "Multimedia"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    lazy var shortsLabel: UILabel = {
       let label = UILabel()
        label.text = "Shorts"
        label.font = UIFont.systemFont(ofSize: 24)
        label.sizeToFit()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var shortsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = 20
        layout.sectionInset = .zero
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(ShortsCollectionViewCell.self, forCellWithReuseIdentifier: ShortsCollectionViewCell.reuseIdentifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }
       
    @objc override func didTapToolBarButton(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            presenter?.didTapHomeButton()
            sender.tintColor = .black
        case 1:
            presenter?.didTapSocialtButton()
            sender.tintColor = .black
        case 2:
            presenter?.didTapStoreButton()
            sender.tintColor = .black
        case 3:
            presenter?.didTapContactButton()
            sender.tintColor = .black
        case 4:
            presenter?.didTapSettingstButton()
            sender.tintColor = .black
        default:
            break
        }
    }
    
    @objc override func didTapProfileView(navigation: UIViewController) {
        presenter?.didTapSettingstButton()
    }

    func start() {
        self.setupView()
        startAutoScroll()
        DispatchQueue.main.async {
            self.presenter?.fetchNews()
            self.presenter?.fetchShorts()
            self.presenter?.fetchMultimedia()
        }
    }
    
    func setupView() {
        
        viewContainer.addSubview(titleLabel)
        viewContainer.addSubview(newsCollectionView)
        viewContainer.addSubview(multimediaLabel)
        viewContainer.addSubview(firtsMangaView)
        viewContainer.addSubview(lastMangaView)
        viewContainer.addSubview(musicView)
        viewContainer.addSubview(shortsLabel)
        viewContainer.addSubview(shortsCollectionView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            
            newsCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            newsCollectionView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 5),
            newsCollectionView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -5),
            newsCollectionView.heightAnchor.constraint(equalToConstant: 150),
            
            multimediaLabel.topAnchor.constraint(equalTo: newsCollectionView.bottomAnchor, constant: 10),
            multimediaLabel.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 10),

            firtsMangaView.topAnchor.constraint(equalTo: multimediaLabel.bottomAnchor, constant: 10),
            firtsMangaView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 10),
            firtsMangaView.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.45),
            firtsMangaView.heightAnchor.constraint(equalToConstant: 200),
            
            lastMangaView.topAnchor.constraint(equalTo: multimediaLabel.bottomAnchor, constant: 10),
            lastMangaView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -10),
            lastMangaView.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.45),
            lastMangaView.heightAnchor.constraint(equalToConstant: 200),
            
            musicView.topAnchor.constraint(equalTo: lastMangaView.bottomAnchor, constant: 15),
            musicView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -10),
            musicView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 10),
            musicView.heightAnchor.constraint(equalToConstant: 100),
            
            shortsLabel.topAnchor.constraint(equalTo: musicView.bottomAnchor, constant: 10),
            shortsLabel.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 10),
            
            shortsCollectionView.topAnchor.constraint(equalTo: shortsLabel.bottomAnchor, constant: 10),
            shortsCollectionView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 10),
            shortsCollectionView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            shortsCollectionView.heightAnchor.constraint(equalToConstant: 200),
            shortsCollectionView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
        ])
    }
    
    private func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    @objc private func scrollToNextItem() {
        guard let modelNews = presenter?.modelNews else { return }
        
        if currentIndex < modelNews.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        
        let indexPath = IndexPath(item: currentIndex, section: 0)
        newsCollectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    
    deinit {
        timer?.invalidate()
    }
    
}

extension SocialViewController: SocialViewProtocol {
    func errorPopUp(title: String, message: String) {
        showErrorPopUp(title: title, message: message)
    }
    
    func fetchMultimedia(multimedia: MultimediaEntity) {
        DispatchQueue.main.async { [weak self] in
            guard let url = URL(string: multimedia.results.mangas.first!.mangaImage) else { return }
            self?.firtsMangaView.configure(image: url, title: multimedia.results.mangas[0].mangaTitle)
            guard let url = URL(string: multimedia.results.mangas.last!.mangaImage) else { return }
            self?.lastMangaView.configure(image: url, title: multimedia.results.mangas.last!.mangaTitle)
            self?.musicView.configure(backgroundImage: multimedia.results.songBackground,music: multimedia.results.songs.first!, count: multimedia.results.songs.count)

            self?.musicView.onPlayButtonTap = { [weak self] in
                self?.presenter?.showSongsList(songsList: multimedia.results.songs)
            }

        }
    }
    
    func fetchShorts(shorts: ShortsEntity) {
        self.shortsCollectionView.reloadData()
    }
    
    func fetchNews(news: NewsEntity) {
        self.newsCollectionView.reloadData()
    }
    
}
