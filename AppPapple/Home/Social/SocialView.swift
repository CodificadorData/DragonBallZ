//
//  AdditionalView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//

import UIKit

class SocialView: UIView {
    
    var presenter: HomePresenter?
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.textColor = .white
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 18)
        title.text = "Social"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, amigo!"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var newsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
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
    
    var firtsMangaView = MangaUIView()
    var lastMangaView = MangaUIView()
    
    lazy var musicView: UIView = {
       let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    lazy var shortsLabel: UILabel = {
       let label = UILabel()
        label.text = "Shorts"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var shortsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(ShortsCollectionViewCell.self, forCellWithReuseIdentifier: ShortsCollectionViewCell.reuseIdentifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private var timer: Timer?
    private var currentIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func start() {
        self.setupView()
        DispatchQueue.main.async {
            self.presenter?.fetchNews()
            self.presenter?.fetchShorts()
            self.presenter?.fetchMultimedia()
        }
        startAutoScroll()
    }
    
    func setupView() {
        self.addSubview(title)
        self.addSubview(greetingLabel)
        self.addSubview(newsCollectionView)
        self.addSubview(multimediaLabel)
        self.addSubview(firtsMangaView)
        self.addSubview(lastMangaView)
        self.addSubview(musicView)
        self.addSubview(shortsLabel)
        self.addSubview(shortsCollectionView)

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            greetingLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            greetingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            newsCollectionView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 10),
            newsCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            newsCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            newsCollectionView.heightAnchor.constraint(equalToConstant: 150),
            
            multimediaLabel.topAnchor.constraint(equalTo: newsCollectionView.bottomAnchor, constant: 10),
            multimediaLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),

            firtsMangaView.topAnchor.constraint(equalTo: multimediaLabel.bottomAnchor, constant: 10),
            firtsMangaView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            firtsMangaView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45),
            firtsMangaView.heightAnchor.constraint(equalToConstant: 200),
            
            lastMangaView.topAnchor.constraint(equalTo: multimediaLabel.bottomAnchor, constant: 10),
            lastMangaView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            lastMangaView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45),
            lastMangaView.heightAnchor.constraint(equalToConstant: 200),
            
            musicView.topAnchor.constraint(equalTo: lastMangaView.bottomAnchor, constant: 10),
            musicView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            musicView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            musicView.heightAnchor.constraint(equalToConstant: 100),
            
            shortsLabel.topAnchor.constraint(equalTo: musicView.bottomAnchor, constant: 10),
            shortsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            shortsCollectionView.topAnchor.constraint(equalTo: shortsLabel.bottomAnchor, constant: 10),
            shortsCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            shortsCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            shortsCollectionView.heightAnchor.constraint(equalToConstant: 200),
            shortsCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
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
extension SocialView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case newsCollectionView:
            return presenter?.modelNews.count ?? 0
        case shortsCollectionView:
            return presenter?.modelShorts.count ?? 0
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            case newsCollectionView:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SocialCollectionViewCell.identifier,
                    for: indexPath
                ) as? SocialCollectionViewCell else {
                    return UICollectionViewCell()
                }
                guard let modelNews = self.presenter?.modelNews else { return cell }
                
                guard let url = URL(string: modelNews[indexPath.row].imageUrl) else { return cell }
                
                cell.configure(title: modelNews[indexPath.row].title, description: modelNews[indexPath.row].description, url: url)
                return cell
            case shortsCollectionView:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ShortsCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as? ShortsCollectionViewCell else {
                    return UICollectionViewCell()
                    }
            guard let modelShorts = self.presenter?.modelShorts else { return cell }
            guard let url = URL(string: modelShorts[indexPath.row].imageShort) else { return cell}
            cell.configure(description: modelShorts[indexPath.row].description, imageUrl: url)
                return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case newsCollectionView:
            return CGSize(width: collectionView.frame.width, height: 150)
        case shortsCollectionView:
            return CGSize(width: 150, height: collectionView.frame.height - 20)
        default:
            return CGSize(width: 0, height: 0)
        }
    }

}

extension SocialView: SocialViewProtocol {
    func fetchMultimedia(multimedia: MultimediaEntity) {
        DispatchQueue.main.async { [weak self] in
            guard let url = URL(string: multimedia.results.mangas.first!.mangaImage) else { return }
            self?.firtsMangaView.configure(image: url, title: multimedia.results.mangas[0].mangaTitle)
            guard let url = URL(string: multimedia.results.mangas.last!.mangaImage) else { return }
            self?.lastMangaView.configure(image: url, title: multimedia.results.mangas.last!.mangaTitle)
        }
    }
    
    func fetchShorts(shorts: ShortsEntity) {
        self.shortsCollectionView.reloadData()
    }
    
    func fetchNews(news: NewsEntity) {
        self.newsCollectionView.reloadData()
    }
    
}
