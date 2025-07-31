//
//  StoreView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//

import UIKit
import Kingfisher

class StoreView: UIView {
    
    var presenter: HomePresenter?
    var contador: CGFloat = 1
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        cv.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        return cv
    }()

    lazy var title: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.text = "Store"
        return title
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    func start() {
        self.setupView()
        DispatchQueue.main.async {
            self.presenter?.fetchProducts()
        }
    }
    
    func setupView() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 1000)
        ])
    }
    
    func showErrorPopUp(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        guard let viewController = self.parentViewController() else {
            return
        }
        viewController.present(alertController, animated: true, completion: nil)
    }

}

extension StoreView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.modelProduct.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCollectionViewCell.identifier,
            for: indexPath
        ) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let modelProduct = self.presenter?.modelProduct else { return cell }
        
        guard let url = URL(string: modelProduct[indexPath.row].image) else { return cell }
        
        cell.configure(with: modelProduct[indexPath.row].name, url: url)
        return cell
    }

    // MARK: - UICollectionView Delegate FlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 40) / 2, height: 150)
    }

}

extension StoreView: StoreViewProtocol {
    func errorPopUp(title: String, message: String) {
        self.showErrorPopUp(title: title, message: message)
    }
    
    func updateProductList(product: ProductEntity) {
        collectionView.reloadData()
    }
}

extension StoreView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let position = scrollView.contentOffset.y
            let heigth = collectionView.frame.height
            if position > contador {
                DispatchQueue.main.async {
                    self.presenter?.fetchProducts()
                }
                contador += heigth
            }
        }
    }
}
