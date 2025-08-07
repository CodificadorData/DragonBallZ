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
        return scroll
    }()
    
    lazy var bannerButton: UIButton = {
        let button = UIButton()
        button.setTitle(">", for: .normal)
        button.contentHorizontalAlignment = .center
        button.clipsToBounds = true
        return button
    }()
    
    lazy var bannerImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    lazy var principalImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    lazy var bannerDescription: UILabel = {
        let description = UILabel()
        description.text = "Todos los personajes cuentan con caracteristicas distintas y estan en la siguiente pantalla:"
        description.textAlignment = .justified
        description.textColor = .white
        description.numberOfLines = 0
        description.font = UIFont.systemFont(ofSize: 15)
        return description
    }()
    
    lazy var bannerTittle: UILabel = {
        let tittle = UILabel()
        tittle.text = "Info de tu Personaje"
        tittle.textAlignment = .center
        tittle.numberOfLines = 0
        tittle.textColor = .white
        tittle.font = UIFont.systemFont(ofSize: 18)
        return tittle
    }()
    
    lazy var viewContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1)
        return container
    }()
    
    lazy var bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 7/255.0, green: 32/255.0, blue: 131/255.0, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var activityIndicatorTableHome: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.color = .gray
        return activity
    }()
    
    lazy var activityIndicatorPrincipalImage: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.color = .black
        return activity
    }()
    
    lazy var activityIndicatorBannerImage: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.hidesWhenStopped = true
        activity.color = .black
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
        activityIndicatorPrincipalImage.startAnimating()
        activityIndicatorTableHome.startAnimating()
        activityIndicatorBannerImage.startAnimating()
        DispatchQueue.main.async {
            self.presenter?.bringData()
        }
        settingsView.presenter = presenter
        presenter?.settingsView = settingsView
        storeView.presenter = presenter
        presenter?.storeView = storeView
        contactView.presenter = presenter
        socialView.presenter = presenter
        presenter?.socialView = socialView
        selectedToolbarItem(selectedButton: homeButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = false
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
        bannerButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        tableHome.delegate = self
        tableHome.dataSource = self
        tableHome.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifi)
        tableHome.tableHeaderView = headerView
        tableHome.addSubview(activityIndicatorTableHome)
        headerView.addSubview(labelHeader)
        principalImage.addSubview(activityIndicatorPrincipalImage)
        bannerImage.addSubview(activityIndicatorBannerImage)
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerButton.translatesAutoresizingMaskIntoConstraints = false
        bannerTittle.translatesAutoresizingMaskIntoConstraints = false
        bannerDescription.translatesAutoresizingMaskIntoConstraints = false
        bannerImage.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollHome.translatesAutoresizingMaskIntoConstraints = false
        tableHome.translatesAutoresizingMaskIntoConstraints = false
        principalImage.translatesAutoresizingMaskIntoConstraints = false
        labelHeader.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorTableHome.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorPrincipalImage.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorBannerImage.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            bannerView.topAnchor.constraint(equalTo: tableHome.bottomAnchor, constant: getBounds(percentage: 2, .height)),
            bannerView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: getBounds(percentage: 2, .width)),
            bannerView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: getBounds(percentage: -2, .width)),
            bannerView.heightAnchor.constraint(equalToConstant: getBounds(percentage: 12, .height)),
            bannerView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: getBounds(percentage: -35, .height)),
            
            bannerButton.heightAnchor.constraint(equalToConstant: getBounds(percentage: 3, .height)),
            bannerButton.widthAnchor.constraint(equalToConstant: getBounds(percentage: 4, .width)),

            bannerButton.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor),
            bannerButton.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor, constant: getBounds(percentage: -2, .width)),
            
            bannerTittle.topAnchor.constraint(equalTo: bannerView.topAnchor, constant: getBounds(percentage: 1, .height)),
            bannerTittle.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor),
            
            bannerDescription.topAnchor.constraint(equalTo: bannerTittle.topAnchor, constant: getBounds(percentage: 3, .height)),
            bannerDescription.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor, constant: getBounds(percentage: -24, .width)),
            bannerDescription.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor, constant: getBounds(percentage: 4, .width)),
            bannerDescription.widthAnchor.constraint(equalToConstant: getBounds(percentage: 45, .width)),
            
            bannerImage.topAnchor.constraint(equalTo: bannerView.topAnchor, constant: getBounds(percentage: 2, .height)),
            bannerImage.leadingAnchor.constraint(equalTo: bannerDescription.trailingAnchor, constant: getBounds(percentage: 1, .width)),
            bannerImage.trailingAnchor.constraint(equalTo: bannerButton.leadingAnchor, constant: getBounds(percentage: -1, .width)),
            bannerImage.heightAnchor.constraint(equalToConstant: getBounds(percentage: 9, .height)),
            
            tableHome.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: getBounds(percentage: 2, .height)),
            tableHome.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: getBounds(percentage: 2, .width)),
            tableHome.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: getBounds(percentage: -48, .width)),
            tableHome.heightAnchor.constraint(equalToConstant: getBounds(percentage: 60, .height)),
            
            principalImage.centerYAnchor.constraint(equalTo: tableHome.centerYAnchor),
            principalImage.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: getBounds(percentage: -2, .width)),
            principalImage.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: getBounds(percentage: 54, .width)),
            principalImage.heightAnchor.constraint(equalToConstant: getBounds(percentage: 50, .height)),
            
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
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 1)]
        self.navigationController?.toolbar.barTintColor = UIColor(red: 210/255.0, green: 105/255.0, blue: 30/255.0, alpha: 1)
        
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
    }
    
    func showErrorPopUp(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getBounds(percentage: Double, _ dimention: Dimention) -> CGFloat {
        var total: CGFloat = 0
        switch dimention {
        case .width :
            total = UIScreen.main.bounds.width
        case .height :
            total = UIScreen.main.bounds.height
        }
        return total * (percentage/100)
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
}

extension HomeView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.modelDragon.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifi, for: indexPath)
        cell.backgroundColor = UIColor(red: 7/255.0, green: 32/255.0, blue: 131/255.0, alpha: 1)
        let personajeNombre = presenter?.modelDragon[indexPath.row].name
        cell.textLabel?.text = personajeNombre
        cell.textLabel?.textColor = .white
        cell.textLabel?.translatesAutoresizingMaskIntoConstraints = false
        guard let textLabel = cell.textLabel else {return cell}
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = presenter?.modelDragon[indexPath.row].image else {
            return
        }
        self.activityIndicatorPrincipalImage.startAnimating()
        self.activityIndicatorBannerImage.startAnimating()
        
        principalImage.kf.setImage(with: URL(string: url), completionHandler: { result in
            switch result {
            case .success(_):
                self.activityIndicatorPrincipalImage.stopAnimating()
            case .failure(let error):
                self.showErrorPopUp(title: "No cargo/no terminó de cargar la imagen", message: error.localizedDescription.description)
            }
        })
        bannerImage.kf.setImage(with: URL(string: url), completionHandler: { result in
            switch result {
            case .success(_):
                self.activityIndicatorBannerImage.stopAnimating()
            case .failure(_):
                break 
            }
        })
        personaje = presenter?.modelDragon[indexPath.row]
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height * 0.1
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

enum Dimention {
    case width
    case height
}
