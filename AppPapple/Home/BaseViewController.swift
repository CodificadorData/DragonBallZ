//
//  BaseViewController.swift
//  AppPapple
//
//  Created by Christian Morante on 10/08/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dragon Ball Z"
        view.backgroundColor = UIColor(red: 210/255.0, green: 105/255.0, blue: 30/255.0, alpha: 1)
        self.navigationController?.isToolbarHidden = false
        navigationItem.hidesBackButton = true
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupToolBar()
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
            action: #selector(profileViewTapped)
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
            action: #selector(buttonToolBarPressed(_:))
        )
        button.tag = type.rawValue
        return button
    }
    
    @objc func buttonToolBarPressed(_ sender: UIBarButtonItem) {
        
    }
    

    @objc func profileViewTapped(navigation: UIViewController) {
//        let settingsView = SettingsViewController()
//        navigation.navigationController?.pushViewController(settingsView, animated: true)
    }

    func showErrorPopUp(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }

}

enum ToolbarButtonType: Int {
    case home, news, store, contact, setting
}

