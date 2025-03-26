//
//  HomeView.swift
//  AppPapple
//
//  Created by Christian Morante on 18/02/24.
//

import Foundation
import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    var presenter: HomePresenter?
    let cellIdentifi = "cell"
    var personaje: Item?
    let router = HomeRouter()

    @IBAction func buttonPressed(_ sender: UIButton) {
        router.goToCharacterDetail(mainView: self, dragonBallModel: personaje!)
    }
    
    //botones del toolbar
    @IBAction func buttonToolBarPressed(_ sender: UIBarButtonItem) {
        switch sender.title {
        case "Home":
            view.subviews.forEach { $0.removeFromSuperview() }
            setupBannerView()
            setupNavigationBar()
        case "Additional":
            view.subviews.forEach { $0.removeFromSuperview() }
            let _ = AdditionalView(view: self)
        case "Store":
            view.subviews.forEach { $0.removeFromSuperview() }
            let _ = StoreView(view: self)
        case "Contact":
            view.subviews.forEach { $0.removeFromSuperview() }
            let _ = ContactView(view: self)
        case "Settings":
            view.subviews.forEach { $0.removeFromSuperview() }
            let _ = SettingsView(view: self)
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
        image.contentMode = .scaleToFill
        return image
    }()
    
    lazy var principalImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Bienvenida")
        image.contentMode = .scaleToFill
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
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupBannerView()
        presenter?.bringData()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = false
    }
    
    @objc func profileViewTapped() {
        view.subviews.forEach { $0.removeFromSuperview() }
        let _ = SettingsView(view: self)
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
        headerView.addSubview(labelHeader)

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
        
        NSLayoutConstraint.activate([
            
            viewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            viewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            scrollHome.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollHome.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollHome.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollHome.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            bannerView.bottomAnchor.constraint(equalTo: tableHome.bottomAnchor, constant: 150),
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
            tableHome.heightAnchor.constraint(equalToConstant: 500),
            tableHome.widthAnchor.constraint(equalToConstant: 200),
            
            principalImage.centerYAnchor.constraint(equalTo: tableHome.centerYAnchor),
            principalImage.rightAnchor.constraint(equalTo: viewContainer.rightAnchor, constant: -20),
            principalImage.heightAnchor.constraint(equalToConstant: 400),
            principalImage.widthAnchor.constraint(equalToConstant: 150),

            labelHeader.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            labelHeader.centerXAnchor.constraint(equalTo: headerView.centerXAnchor)
            
        ])

    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 1)]
        self.navigationController?.toolbar.barTintColor = UIColor(red: 210/255.0, green: 105/255.0, blue: 30/255.0, alpha: 1)
        
        
//        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40)) // Ajusta el tamaño
//        let titleLabel = UILabel()
//        titleLabel.text = "Dragon Ball Z"
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        titleLabel.textColor = .black
//        titleLabel.textAlignment = .center
//
//        // Usa un stack view para manejar alineaciones
//        let stackView = UIStackView(arrangedSubviews: [titleLabel])
//        stackView.axis = .horizontal
//        stackView.alignment = .center
//        stackView.frame = titleView.bounds
//
//        titleView.addSubview(stackView)
//
//        navigationItem.titleView = titleView
        
        
        let image = UIImage(named: "userImage")?.withRenderingMode(.alwaysOriginal)

        // Ajustar el tamaño de la imagen manualmente
        let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            image?.draw(in: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        }

        let button = UIBarButtonItem(image: resizedImage, style: .plain, target: self, action: #selector(profileViewTapped))

        navigationItem.rightBarButtonItem = button
        
        let toolbarItem = [
        UIBarButtonItem(
            title: "Home",
            style: .done,
            target: self,
            action: #selector(buttonToolBarPressed(_:))
        ), UIBarButtonItem(
            title: "Additional",
            style: .done,
            target: self,
            action: #selector(buttonToolBarPressed(_:))
        ), UIBarButtonItem(
            title: "Store",
            style: .done,
            target: self,
            action: #selector(buttonToolBarPressed(_:))
        ), UIBarButtonItem(
            title: "Contact",
            style: .done,
            target: self,
            action: #selector(buttonToolBarPressed(_:))
        ), UIBarButtonItem(
            title: "Settings",
            style: .done,
            target: self,
            action: #selector(buttonToolBarPressed(_:))
        )]
        toolbarItems = toolbarItem
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.modelDragon.count)!
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
        bannerImage.kf.setImage(with: URL(string: url))
        principalImage.kf.setImage(with: URL(string: url))
        personaje = (presenter?.modelDragon[indexPath.row])!
    }
}

extension HomeViewController: DragonBallUI {
    func updateDragonBall(dragonBallList: [Item]) {
        DispatchQueue.main.async {
            let imageFirst = self.presenter!.modelDragon.first!.image
            self.tableHome.reloadData()
            self.principalImage.kf.setImage(with: URL(string: imageFirst))
            self.bannerImage.kf.setImage(with: URL(string: imageFirst))
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableHome.delegate?.tableView?(self.tableHome, didSelectRowAt: indexPath)
        }
    }
    
    
}
