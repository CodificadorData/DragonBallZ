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
    var contactView: ContactView?
    var socialView: SocialView?
    var settingsView: SettingsView?
    var storeView: StoreView?
    let cellIdentifi = "cell"
    var personaje: Item?
    var isLoading = false // Para evitar múltiples cargas simultáneas
    var contador: CGFloat = 1
    
    var homeButton: UIBarButtonItem!
    var newsButton: UIBarButtonItem!
    var storeButton: UIBarButtonItem!
    var contactButton: UIBarButtonItem!
    var settingButton: UIBarButtonItem!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        presenter?.goToCharacterDetail(dragonBallModel: personaje!)
    }
    
    @IBAction func buttonToolBarPressed(_ sender: UIBarButtonItem) {
        switch sender {
        case homeButton:
            view.subviews.forEach { $0.removeFromSuperview() }
            setupBannerView()
            setupNavigationBar()
        case newsButton:
            view.subviews.forEach { $0.removeFromSuperview() }
            self.setupConstraintsView(uiView: self.socialView!)
        case storeButton:
            view.subviews.forEach { $0.removeFromSuperview() }
            self.setupConstraintsView(uiView: self.storeView!)
            DispatchQueue.main.async {
                self.presenter?.fetchProducts()
            }
        case contactButton:
            view.subviews.forEach { $0.removeFromSuperview() }
            self.setupConstraintsView(uiView: self.contactView!)
        case settingButton:
            view.subviews.forEach { $0.removeFromSuperview() }
            setupConstraintsView(uiView: self.settingsView!)
        default:
            break
        }
    }

    lazy var tableHome: UITableView = {
        let table = UITableView()
        table.backgroundColor = .darkGray
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
        labelHeader.textColor = .black
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
        scroll.contentSize = CGSize(width: viewContainer.frame.width, height: 1000)
        return scroll
    }()
    
    lazy var bannerButton: UIButton = {
        let button = UIButton()
        button.setTitle(">", for: .normal)
        return button
    }()
    
    lazy var bannerImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var principalImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var bannerDescription: UILabel = {
        let description = UILabel()
        description.text = "Todos los personajes cuentan con caracteristicas distintas y estas las podrás averiguar en la siguiente pantalla:"
        description.textAlignment = .center
        description.textColor = .black
        description.numberOfLines = 0
        description.font = UIFont.systemFont(ofSize: 12)
        return description
    }()
    
    lazy var bannerTittle: UILabel = {
        let tittle = UILabel()
        tittle.text = "Info de tu Personaje"
        tittle.textAlignment = .center
        tittle.numberOfLines = 0
        tittle.textColor = .black
        tittle.font = UIFont.systemFont(ofSize: 16)
        return tittle
    }()
    
    lazy var viewContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(red: 255/255.0, green: 140/255.0, blue: 0/255.0, alpha: 1)
        return container
    }()
    
    lazy var bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 35/255.0, green: 78/255.0, blue: 178/255.0, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
        
    lazy var activityIndicatorTableHome: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.color = .black
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
        self.settingsView = SettingsView(presenter: presenter!)
        self.contactView = ContactView(presenter: presenter!)
        self.socialView = SocialView(presenter: presenter!)
        self.storeView = StoreView()
        storeView?.presenter = presenter!
        presenter?.storeView = self.storeView
        setupBannerView()
        setupNavigationBar()
        activityIndicatorPrincipalImage.startAnimating()
        activityIndicatorTableHome.startAnimating()
        activityIndicatorBannerImage.startAnimating()
        DispatchQueue.main.async {
            self.presenter?.bringData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = false
    }
    
    @objc func profileViewTapped() {
        view.subviews.forEach { $0.removeFromSuperview() }
        self.setupConstraintsView(uiView: settingsView!)
    }
    
    func setupBannerView() {
        self.title = "Dragon Ball Z"
        view.backgroundColor = UIColor(red: 210/255.0, green: 105/255.0, blue: 30/255.0, alpha: 1)
        view.addSubview(viewContainer)
        viewContainer.addSubview(scrollHome)
        scrollHome.addSubview(bannerView)
        scrollHome.addSubview(tableHome)
        scrollHome.addSubview(principalImage)
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
            
            viewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            viewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            scrollHome.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollHome.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollHome.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollHome.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            bannerView.bottomAnchor.constraint(equalTo: tableHome.bottomAnchor, constant: 120),
            bannerView.centerXAnchor.constraint(equalTo: scrollHome.centerXAnchor),
            bannerView.widthAnchor.constraint(equalToConstant: 327),
            bannerView.heightAnchor.constraint(equalToConstant: 104),
            
            bannerButton.widthAnchor.constraint(equalToConstant: 20),
            bannerButton.heightAnchor.constraint(equalToConstant: 20),
            bannerButton.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor),
            bannerButton.rightAnchor.constraint(equalTo: bannerView.rightAnchor, constant: -10),
            
            bannerTittle.topAnchor.constraint(equalTo: bannerView.topAnchor, constant: 10),
            bannerTittle.widthAnchor.constraint(equalTo: bannerView.widthAnchor, multiplier: 0.9),
            bannerTittle.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor),
            
            bannerDescription.topAnchor.constraint(equalTo: bannerTittle.topAnchor, constant: 25),
            bannerDescription.rightAnchor.constraint(equalTo: bannerImage.leftAnchor, constant: -5),
            bannerDescription.leftAnchor.constraint(equalTo: bannerView.leftAnchor, constant: 20),
            bannerDescription.widthAnchor.constraint(equalToConstant: 100),
            
            bannerImage.topAnchor.constraint(equalTo: bannerView.topAnchor, constant: 20),
            bannerImage.rightAnchor.constraint(equalTo: bannerView.rightAnchor, constant: -50),
            bannerImage.heightAnchor.constraint(equalToConstant: 80),
            bannerImage.widthAnchor.constraint(equalToConstant: 30),
            
            tableHome.topAnchor.constraint(equalTo: scrollHome.topAnchor, constant: 20),
            tableHome.leftAnchor.constraint(equalTo: scrollHome.leftAnchor, constant: 20),
            tableHome.leadingAnchor.constraint(equalTo: scrollHome.leadingAnchor),
            tableHome.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.6),
            tableHome.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.5),
            
            principalImage.centerYAnchor.constraint(equalTo: tableHome.centerYAnchor),
            principalImage.rightAnchor.constraint(equalTo: viewContainer.rightAnchor, constant: -20),
            principalImage.heightAnchor.constraint(equalToConstant: 400),
            principalImage.widthAnchor.constraint(equalToConstant: 150),

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
        
        let image = UIImage(named: "userImage")?.withRenderingMode(.alwaysOriginal)

        let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            image?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }

        let button = UIBarButtonItem(
            image: resizedImage,
            style: .plain,
            target: self,
            action: #selector(profileViewTapped)
        )
        
        navigationItem.rightBarButtonItem = button
        
        let homeIcon = UIImage(named: "homeIcon")?.withRenderingMode(.alwaysOriginal)
        let newsIcon = UIImage(named: "newsIcon")?.withRenderingMode(.alwaysOriginal)
        let settingIcon = UIImage(named: "settingIcon")?.withRenderingMode(.alwaysOriginal)
        let contactIcon = UIImage(named: "contactIcon")?.withRenderingMode(.alwaysOriginal)
        let storeIcon = UIImage(named: "storeIcon")?.withRenderingMode(.alwaysOriginal)

        
        let homeIconResized = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            homeIcon?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }
        
        let newsIconResized = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            newsIcon?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }
        
        let settingIconResized = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            settingIcon?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }

        let contactIconResized = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            contactIcon?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }

        let storeIconResized = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
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
}

extension HomeView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.modelDragon.count) ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifi, for: indexPath)
        cell.backgroundColor = .brown
        let personajeNombre = presenter?.modelDragon[indexPath.row].name
        cell.textLabel?.text = personajeNombre
        
        cell.textLabel?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cell.textLabel!.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            cell.textLabel!.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
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
            case .failure(_):
                print("No cargo/no terminó de cargar la imagen")
            }
        })
        bannerImage.kf.setImage(with: URL(string: url), completionHandler: { result in
            switch result {
            case .success(_):
                self.activityIndicatorBannerImage.stopAnimating()
            case .failure(_):
                print("No cargo/no terminó de cargar la imagen")
            }
        })
        personaje = (presenter?.modelDragon[indexPath.row])!
    }
    
    func setupConstraintsView(uiView: UIView) {
        view.addSubview(uiView)
        uiView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uiView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            uiView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            uiView.bottomAnchor.constraint(equalTo: self.navigationController?.toolbar.topAnchor ?? self.view.bottomAnchor),
            uiView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height * 0.1
    }
}

extension HomeView: HomeViewProtocol {
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


