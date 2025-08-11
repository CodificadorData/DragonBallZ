//
//  StoreView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//

import UIKit
import Kingfisher

class StoreViewController: BaseViewController {
    
    var presenter: StorePresenter?
    var contador: CGFloat = 1
    
    lazy var scrollHome: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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

    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.text = "Store"
        return title
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
    
    @objc override func buttonToolBarPressed(_ sender: UIBarButtonItem) {
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

    @objc override func profileViewTapped(navigation: UIViewController) {
        presenter?.didTapSettingstButton()
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
        
        view.addSubview(scrollHome)
        scrollHome.addSubview(containerView)
        containerView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            scrollHome.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollHome.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollHome.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollHome.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            containerView.topAnchor.constraint(equalTo: scrollHome.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollHome.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollHome.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollHome.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollHome.widthAnchor),
            
            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 1000)
        ])
    }
    
}

extension StoreViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

extension StoreViewController: StoreViewProtocol {
    func errorPopUp(title: String, message: String) {
        self.showErrorPopUp(title: title, message: message)
    }
    
    func updateProductList(product: ProductEntity) {
        collectionView.reloadData()
    }
}

extension StoreViewController: UIScrollViewDelegate {
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
