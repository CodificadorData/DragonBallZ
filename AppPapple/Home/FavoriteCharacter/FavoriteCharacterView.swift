//
//  FavoriteCharacterView.swift
//  AppPapple
//
//  Created by Christian Morante on 25/08/25.
//

import UIKit

class FavoriteCharacterView: UIViewController {
    
    var presenter: FavoriteCharacterPresenter?
    var favoriteCharacters: [FavoriteCharacter] = []
    
    lazy var favoriteCharacterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .orange
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(FavoriteCharacterViewCell.self, forCellWithReuseIdentifier: FavoriteCharacterViewCell.reusableIdentifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.clipsToBounds = true
        collection.showsVerticalScrollIndicator = false
        collection.contentInsetAdjustmentBehavior = .never
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
        view.backgroundColor = UIColor(red: 210/255.0, green: 105/255.0, blue: 30/255.0, alpha: 1)
        setup()
        presenter?.fetchCharacters()
    }
    
    func setup() {
        view.addSubview(favoriteCharacterCollectionView)
        NSLayoutConstraint.activate([
            favoriteCharacterCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            favoriteCharacterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteCharacterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteCharacterCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            favoriteCharacterCollectionView.heightAnchor.constraint(equalToConstant: 1000)
        ])
    }
    
}

extension FavoriteCharacterView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.favoriteCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FavoriteCharacterViewCell.reusableIdentifier,
            for: indexPath
        ) as? FavoriteCharacterViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(character: self.favoriteCharacters[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 50, height: 100 )
    }

}

extension FavoriteCharacterView: FavoriteCharacterViewProtocol {
    func fetchResults(result: [FavoriteCharacter]) {
        self.favoriteCharacters = result
        favoriteCharacterCollectionView.reloadData()
    }
    
    
}
