//
//  BaseViewController.swift
//  AppPapple
//
//  Created by Christian Morante on 10/08/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var scrollHome: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var viewContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dragon Ball Z"
        view.backgroundColor = UIColor(red: 210/255.0, green: 105/255.0, blue: 30/255.0, alpha: 1)
        self.navigationController?.isToolbarHidden = false
        navigationItem.hidesBackButton = true
        setupNavigationBar()
        view.addSubview(scrollHome)
        scrollHome.addSubview(viewContainer)
        setupUIGeneral()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupToolBar()
    }
    
    func setupUIGeneral() {
        NSLayoutConstraint.activate([
            scrollHome.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollHome.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollHome.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollHome.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            viewContainer.topAnchor.constraint(equalTo: scrollHome.topAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: scrollHome.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: scrollHome.trailingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: scrollHome.bottomAnchor),
            viewContainer.widthAnchor.constraint(equalTo: scrollHome.widthAnchor),
        ])
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(
            red: 210/255.0, green: 105/255.0, blue: 30/255.0, alpha: 1
        )
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 1)]
        let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            let image = UIImage(named: "userImage")
            image?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }
        let button = UIBarButtonItem(
            image: resizedImage,
            style: .plain,
            target: self,
            action: #selector(didTapProfileView)
        )
        navigationItem.rightBarButtonItem = button
    }
    
    func setupToolBar() {
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.barTintColor = UIColor(
            red: 210/255.0, green: 105/255.0, blue: 30/255.0, alpha: 1
        )
        let buttons: [ToolbarButtonType] = [.home, .news, .store, .contact, .setting]
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = buttons.flatMap { type in
            [makeToolbarButton(for: type), space]
        }.dropLast()
    }
    
    private func makeToolbarButton(for type: ToolbarButtonType) -> UIBarButtonItem {
        let iconName: String
        switch type {
        case .home: iconName = "homeIcon"
        case .news: iconName = "newsIcon"
        case .store: iconName = "storeIcon"
        case .contact: iconName = "contactIcon"
        case .setting: iconName = "settingIcon"
        }
        let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            UIImage(named: iconName)?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }
        let button = UIBarButtonItem(
            image: resizedImage,
            style: .plain,
            target: self,
            action: #selector(didTapToolBarButton(_:))
        )
        button.tag = type.rawValue
        return button
    }
    
    func showErrorPopUp(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func didTapToolBarButton(_ sender: UIBarButtonItem) {
    }
    
    @objc func didTapProfileView(navigation: UIViewController) {
    }
}
