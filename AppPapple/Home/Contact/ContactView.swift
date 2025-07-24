//
//  ContactView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//


import UIKit

class ContactView: UIView {
    
    var presenter: HomePresenter?

    lazy var title: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 18, weight: .bold)
        title.textColor = .black
        title.text = "Contact"
        return title
    }()
    
    lazy var contactInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Hola! Te puedes poner en contacto con nosotros llenando este formulario y visitándonos en nuestras redes sociales que están debajo de esta página. Muchas gracias por visitarnos. ¡Que tengas un buen día! Hola! Te puedes poner en contacto con nosotros llenando este formulario y visitándonos en nuestras redes sociales que están debajo de esta página. Muchas gracias por visitarnos. ¡Que tengas un buen día! Hola! Te puedes poner en contacto con nosotros llenando este formulario y visitándonos en nuestras redes sociales que están debajo de esta página. Muchas gracias por visitarnos. ¡Que tengas un buen día! Hola! Te puedes poner en contacto con nosotros llenando este formulario y visitándonos en nuestras redes sociales que están debajo de esta página. Muchas gracias por visitarnos. ¡Que tengas un buen día! Hola! Te puedes poner en contacto con nosotros llenando este formulario y visitándonos en nuestras redes sociales que están debajo de esta página. Muchas gracias por visitarnos. ¡Que tengas un buen día!"
        return label
    }()
    
    lazy var facebookImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(facebookImageTapped))
        image.addGestureRecognizer(tapGesture)
        image.image = UIImage(named: "facebookIcon")
        return image
    }()
    
    lazy var instagramImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "instagramIcon")
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(instagramImageTapped))
        image.addGestureRecognizer(tapGesture)
        return image
    }()
    
    lazy var youtubeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "youtubeIcon")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(youtubeImageTapped))
        image.addGestureRecognizer(tapGesture)
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(presenter: HomePresenter) {
        super.init(frame: .zero)
        self.setupView()
        self.presenter = presenter
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
        self.addSubview(title)
        self.addSubview(contactInfoLabel)
        self.addSubview(facebookImage)
        self.addSubview(instagramImage)
        self.addSubview(youtubeImage)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        facebookImage.translatesAutoresizingMaskIntoConstraints = false
        youtubeImage.translatesAutoresizingMaskIntoConstraints = false
        contactInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        instagramImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            contactInfoLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            contactInfoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            contactInfoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            facebookImage.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 20),
            facebookImage.widthAnchor.constraint(equalToConstant: 25),
            facebookImage.heightAnchor.constraint(equalToConstant: 25),
            facebookImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            instagramImage.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 20),
            instagramImage.widthAnchor.constraint(equalToConstant: 25),
            instagramImage.heightAnchor.constraint(equalToConstant: 25),
            instagramImage.leadingAnchor.constraint(equalTo: facebookImage.trailingAnchor, constant: 20),

            youtubeImage.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 20),
            youtubeImage.widthAnchor.constraint(equalToConstant: 25),
            youtubeImage.heightAnchor.constraint(equalToConstant: 25),
            youtubeImage.leadingAnchor.constraint(equalTo: instagramImage.trailingAnchor, constant: 20)
        ])
        
        DispatchQueue.main.async {
            self.facebookImage.layoutIfNeeded()
            self.facebookImage.layer.cornerRadius = self.facebookImage.frame.width / 2
            self.facebookImage.clipsToBounds = true
            
            self.instagramImage.layoutIfNeeded()
            self.instagramImage.layer.cornerRadius = self.instagramImage.frame.width / 2
            self.instagramImage.clipsToBounds = true

            self.youtubeImage.layoutIfNeeded()
            self.youtubeImage.layer.cornerRadius = self.youtubeImage.frame.width / 2
            self.youtubeImage.clipsToBounds = true

        }

        backgroundColor = .yellow
    }
    
    
}
