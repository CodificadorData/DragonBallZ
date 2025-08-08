//
//  HomeView.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import UIKit
import Kingfisher

class HomeView: UIViewController {
    
    var presenter: HomePresenter?
    var contactView = ContactView()
    var socialView = SocialView()
    var settingsView = SettingsView()
    var storeView = StoreView()
    let cellIdentifi = "cell"
    var personaje: Item?
    var isLoading = false // Para evitar múltiples cargas simultáneas
    var contador: CGFloat = 1
    
    var homeButton = UIBarButtonItem()
    var newsButton = UIBarButtonItem()
    var storeButton = UIBarButtonItem()
    var contactButton = UIBarButtonItem()
    var settingButton = UIBarButtonItem()
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        presenter?.goToCharacterDetail(dragonBallModel: personaje!)
    }
    
    @IBAction func buttonToolBarPressed(_ sender: UIBarButtonItem) {
        switch sender {
        case homeButton:
            scrollHome.subviews.forEach { $0.removeFromSuperview() }
            setupUI()
            selectedToolbarItem(selectedButton: sender)
        case newsButton:
            scrollHome.subviews.forEach { $0.removeFromSuperview() }
            setupConstraintsView(uiView: self.socialView)
            socialView.start()
            selectedToolbarItem(selectedButton: sender)
        case storeButton:
            scrollHome.subviews.forEach { $0.removeFromSuperview() }
            setupConstraintsView(uiView: self.storeView)
            storeView.start()
            selectedToolbarItem(selectedButton: sender)
        case contactButton:
            scrollHome.subviews.forEach { $0.removeFromSuperview() }
            setupConstraintsView(uiView: self.contactView)
            contactView.start()
            selectedToolbarItem(selectedButton: sender)
        case settingButton:
            scrollHome.subviews.forEach { $0.removeFromSuperview() }
            setupConstraintsView(uiView: self.settingsView)
            settingsView.start()
            selectedToolbarItem(selectedButton: sender)
        default:
            break
        }
    }
    
    lazy var tableHome: UITableView = {
        let table = UITableView()
        table.backgroundColor = .black
        table.layer.cornerRadius = 15
        table.clipsToBounds = true
        table.rowHeight = 50.0
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifi)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    lazy var headerView: UIView = {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableHome.frame.width, height: 44))
        return header
    }()
    
    lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Personajes"
        labelHeader.textAlignment = .center
        labelHeader.font = UIFont.boldSystemFont(ofSize: 18)
        labelHeader.textColor = .white
        labelHeader.translatesAutoresizingMaskIntoConstraints = false
        return labelHeader
    }()
    
    lazy var tableCellHome: UITableViewCell = {
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        return cell
    }()
    
    lazy var scrollHome: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var bannerButton: UIButton = {
        let button = UIButton()
        button.setTitle(">", for: .normal)
        button.contentHorizontalAlignment = .center
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var bannerImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var principalImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var bannerDescription: UILabel = {
        let description = UILabel()
        description.text = "Todos los personajes cuentan con caracteristicas distintas, Todos los personajes cuentan con caracteristicas distintas"
        description.textAlignment = .center
        description.textColor = .white
        description.numberOfLines = 0
        description.font = UIFont.systemFont(ofSize: 15)
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    lazy var bannerTittle: UILabel = {
        let tittle = UILabel()
        tittle.text = "Info de tu Personaje"
        tittle.textAlignment = .center
        tittle.numberOfLines = 0
        tittle.textColor = .white
        tittle.font = UIFont.systemFont(ofSize: 18)
        tittle.translatesAutoresizingMaskIntoConstraints = false
        return tittle
    }()
    
    lazy var viewContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 7/255.0, green: 32/255.0, blue: 131/255.0, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var activityIndicatorTableHome: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.color = .gray
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    lazy var activityIndicatorPrincipalImage: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.color = .black
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    lazy var activityIndicatorBannerImage: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.hidesWhenStopped = true
        activity.color = .black
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.title = "Dragon Ball Z"
        view.backgroundColor = UIColor(red: 210/255.0, green: 105/255.0, blue: 30/255.0, alpha: 1)
        view.addSubview(scrollHome)
        setupUI()
        setupNavigationBar()
        setupToolBar()
        activityIndicatorPrincipalImage.startAnimating()
        activityIndicatorTableHome.startAnimating()
        activityIndicatorBannerImage.startAnimating()
        injectDependenciesIntoViews()
        DispatchQueue.main.async {
            self.presenter?.bringData()
        }
    }
        
    @objc func profileViewTapped() {
        scrollHome.subviews.forEach { $0.removeFromSuperview() }
        setupConstraintsView(uiView: self.settingsView)
        settingsView.start()
    }
    
    func setupUI() {
        scrollHome.addSubview(viewContainer)
        viewContainer.addSubview(bannerView)
        viewContainer.addSubview(tableHome)
        viewContainer.addSubview(principalImage)
        bannerView.addSubview(bannerButton)
        bannerView.addSubview(bannerTittle)
        bannerView.addSubview(bannerDescription)
        bannerView.addSubview(bannerImage)
        tableHome.tableHeaderView = headerView
        tableHome.addSubview(activityIndicatorTableHome)
        headerView.addSubview(labelHeader)
        principalImage.addSubview(activityIndicatorPrincipalImage)
        bannerImage.addSubview(activityIndicatorBannerImage)
        
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
            
            bannerView.topAnchor.constraint(equalTo: tableHome.bottomAnchor, constant: 10),
            bannerView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 10),
            bannerView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -10),
            bannerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.11),
            bannerView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            
            bannerButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03),
            bannerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.04),
            bannerButton.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor),
            bannerButton.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor, constant: -15),
            
            bannerImage.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor),
            bannerImage.leadingAnchor.constraint(equalTo: bannerButton.leadingAnchor, constant: -50),
            bannerImage.trailingAnchor.constraint(equalTo: bannerButton.leadingAnchor),
            bannerImage.heightAnchor.constraint(equalTo: bannerView.heightAnchor, multiplier: 0.8),

            bannerTittle.topAnchor.constraint(equalTo: bannerView.topAnchor, constant: 10),
            bannerTittle.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor),
            
            bannerDescription.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor, constant: 10),
            bannerDescription.trailingAnchor.constraint(equalTo: bannerImage.leadingAnchor, constant: -5),
            bannerDescription.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor, constant: 15),
                        
            tableHome.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 10),
            tableHome.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 10),
            tableHome.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            tableHome.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65),
            
            principalImage.centerYAnchor.constraint(equalTo: tableHome.centerYAnchor),
            principalImage.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -10),
            principalImage.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            principalImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            labelHeader.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            labelHeader.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            activityIndicatorTableHome.centerYAnchor.constraint(equalTo: tableHome.centerYAnchor),
            activityIndicatorTableHome.centerXAnchor.constraint(equalTo: tableHome.centerXAnchor),
            
            activityIndicatorPrincipalImage.centerYAnchor.constraint(equalTo: principalImage.centerYAnchor),
            activityIndicatorPrincipalImage.centerXAnchor.constraint(equalTo: principalImage.centerXAnchor),
            
            activityIndicatorBannerImage.centerYAnchor.constraint(equalTo: bannerImage.centerYAnchor),
            activityIndicatorBannerImage.centerXAnchor.constraint(equalTo: bannerImage.centerXAnchor)
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
            action: #selector(profileViewTapped)
        )
        navigationItem.rightBarButtonItem = button
    }
    
    func setupToolBar() {
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.barTintColor = UIColor(
            red: 210/255.0, green: 105/255.0, blue: 30/255.0, alpha: 1
        )
        let homeIconResized = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            let homeIcon = UIImage(named: "homeIcon")
            homeIcon?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }
        
        let newsIconResized = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            let newsIcon = UIImage(named: "newsIcon")
            newsIcon?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }
        
        let settingIconResized = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            let settingIcon = UIImage(named: "settingIcon")
            settingIcon?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }
        
        let contactIconResized = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            let contactIcon = UIImage(named: "contactIcon")
            contactIcon?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }
        
        let storeIconResized = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            let storeIcon = UIImage(named: "storeIcon")
            storeIcon?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }
        
        homeButton = UIBarButtonItem(
            image: homeIconResized,
            style: .plain,
            target: self,
            action: #selector(buttonToolBarPressed(_:))
        )
        
        newsButton = UIBarButtonItem(
            image: newsIconResized,
            style: .plain,
            target: self,
            action: #selector(buttonToolBarPressed(_:))
        )
        
        settingButton = UIBarButtonItem(
            image: settingIconResized,
            style: .plain,
            target: self,
            action: #selector(buttonToolBarPressed(_:))
        )
        
        contactButton = UIBarButtonItem(
            image: contactIconResized,
            style: .plain,
            target: self,
            action: #selector(buttonToolBarPressed(_:))
        )
        
        storeButton = UIBarButtonItem(
            image: storeIconResized,
            style: .plain,
            target: self,
            action: #selector(buttonToolBarPressed(_:))
        )
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbarItems = [homeButton, space, newsButton, space, storeButton, space, contactButton, space, settingButton]
        selectedToolbarItem(selectedButton: homeButton)
    }
    
    func showErrorPopUp(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
        
    func setupConstraintsView(uiView: UIView) {
        scrollHome.addSubview(uiView)
        uiView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uiView.topAnchor.constraint(equalTo: scrollHome.topAnchor),
            uiView.leadingAnchor.constraint(equalTo: scrollHome.leadingAnchor),
            uiView.trailingAnchor.constraint(equalTo: scrollHome.trailingAnchor),
            uiView.bottomAnchor.constraint(equalTo: scrollHome.bottomAnchor),
            uiView.widthAnchor.constraint(equalTo: scrollHome.widthAnchor)
        ])
    }
    
    func selectedToolbarItem(selectedButton: UIBarButtonItem) {
        let buttons = [homeButton, newsButton, storeButton, contactButton, settingButton]
        for button in buttons {
            button.tintColor = (button == selectedButton) ? .black : .darkGray
        }
    }
    
    func injectDependenciesIntoViews() {
        settingsView.presenter = presenter
        presenter?.settingsView = settingsView
        storeView.presenter = presenter
        presenter?.storeView = storeView
        contactView.presenter = presenter
        socialView.presenter = presenter
        presenter?.socialView = socialView
    }
}

extension HomeView: HomeViewProtocol {
    
    func errorPopUp(title: String, message: String) {
        self.showErrorPopUp(title: title, message: message)
    }
    
    func updateDragonBall(dragonBallList: [Item]) {
        self.tableHome.reloadData()
        activityIndicatorTableHome.stopAnimating()
        if !isLoading {
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableHome.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            self.tableView(self.tableHome, didSelectRowAt: indexPath)
            isLoading = true
        }
    }
    
}

extension HomeView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableHome {
            let position = scrollView.contentOffset.y
            let heigth = tableHome.frame.height
            if position > contador {
                DispatchQueue.main.async {
                    self.presenter?.bringData()
                }
                contador += heigth
            }
        }
    }
    
}
