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
        label.font = UIFont.systemFont(ofSize: 24)
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
        }
        startAutoScroll()
    }
    
    func setupView() {
        self.addSubview(title)
        self.addSubview(greetingLabel)
        self.addSubview(newsCollectionView)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            greetingLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            greetingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            newsCollectionView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 10),
            newsCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            newsCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            newsCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            newsCollectionView.heightAnchor.constraint(equalToConstant: 150)
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
        return presenter?.modelNews.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }

}

extension SocialView: SocialViewProtocol {
    func fetchNews(news: NewsEntity) {
        self.newsCollectionView.reloadData()
    }
    
}
