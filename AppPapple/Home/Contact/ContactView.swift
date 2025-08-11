//
//  ContactView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//


import UIKit

class ContactViewController: BaseViewController {
    
    var presenter: ContactPresenter?
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 18, weight: .bold)
        title.textColor = .white
        title.text = "Contact"
        return title
    }()
    
    lazy var contactInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = NSLocalizedString("infoContactString", comment: "")
        return label
    }()
    
    lazy var facebookImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(facebookImageTapped))
        image.addGestureRecognizer(tapGesture)
        image.image = UIImage(named: "facebookIcon")
        return image
    }()
    
    lazy var instagramImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "instagramIcon")
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(instagramImageTapped))
        image.addGestureRecognizer(tapGesture)
        return image
    }()
    
    lazy var youtubeImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "youtubeIcon")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(youtubeImageTapped))
        image.addGestureRecognizer(tapGesture)
        return image
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
    
    @objc override func didTapToolBarButton(_ sender: UIBarButtonItem) {
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

    @objc override func didTapProfileView(navigation: UIViewController) {
        presenter?.didTapSettingstButton()
    }

    func start() {
        self.setupView()
    }
    
    @objc func facebookImageTapped() {
        presenter?.goToSocialMedia(socialMedia: .facebook)
    }
    
    @objc func instagramImageTapped() {
        presenter?.goToSocialMedia(socialMedia: .instagram)
    }
    
    @objc func youtubeImageTapped() {
        presenter?.goToSocialMedia(socialMedia: .youtube)
    }
    
    func setupView() {
        viewContainer.addSubview(titleLabel)
        viewContainer.addSubview(contactInfoLabel)
        viewContainer.addSubview(facebookImageView)
        viewContainer.addSubview(instagramImageView)
        viewContainer.addSubview(youtubeImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        facebookImageView.translatesAutoresizingMaskIntoConstraints = false
        youtubeImageView.translatesAutoresizingMaskIntoConstraints = false
        contactInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        instagramImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            
            contactInfoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            contactInfoLabel.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 20),
            contactInfoLabel.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -20),
            
            facebookImageView.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 20),
            facebookImageView.widthAnchor.constraint(equalToConstant: 25),
            facebookImageView.heightAnchor.constraint(equalToConstant: 25),
            facebookImageView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 20),
            
            instagramImageView.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 20),
            instagramImageView.widthAnchor.constraint(equalToConstant: 25),
            instagramImageView.heightAnchor.constraint(equalToConstant: 25),
            instagramImageView.leadingAnchor.constraint(equalTo: facebookImageView.trailingAnchor, constant: 20),

            youtubeImageView.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 20),
            youtubeImageView.widthAnchor.constraint(equalToConstant: 25),
            youtubeImageView.heightAnchor.constraint(equalToConstant: 25),
            youtubeImageView.leadingAnchor.constraint(equalTo: instagramImageView.trailingAnchor, constant: 20),
            youtubeImageView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor)
        ])
        
        DispatchQueue.main.async {
            self.facebookImageView.layoutIfNeeded()
            self.facebookImageView.layer.cornerRadius = self.facebookImageView.frame.width / 2
            self.facebookImageView.clipsToBounds = true
            
            self.instagramImageView.layoutIfNeeded()
            self.instagramImageView.layer.cornerRadius = self.instagramImageView.frame.width / 2
            self.instagramImageView.clipsToBounds = true

            self.youtubeImageView.layoutIfNeeded()
            self.youtubeImageView.layer.cornerRadius = self.youtubeImageView.frame.width / 2
            self.youtubeImageView.clipsToBounds = true
        }
    }
}

extension ContactViewController: ContactViewProtocol {
    
}
