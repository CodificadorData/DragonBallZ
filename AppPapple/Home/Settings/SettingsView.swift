//
//  SettingsView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//

import UIKit
import Kingfisher

class SettingsViewController: BaseViewController {
    
    var presenter: SettingsPresenter?
    
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

    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "userImage")
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappableProfilePicture))
        image.addGestureRecognizer(tapGesture)
        return image
    }()

    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.text = "My account"
        title.textAlignment = .center
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        return title
    }()
            
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18, weight: .medium)
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: " name",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        textField.textAlignment = .left
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = .init(red: 156, green: 156, blue: 156, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var surNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18, weight: .medium)
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: " surName",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        textField.textAlignment = .left
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = .init(red: 156, green: 156, blue: 156, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        return textField
    }()

    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18, weight: .medium)
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: " email",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        textField.textAlignment = .left
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = .init(red: 156, green: 156, blue: 156, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        return textField
    }()

    lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18, weight: .medium)
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: " phoneNumber",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        textField.textAlignment = .left
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = .init(red: 156, green: 156, blue: 156, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        return textField
    }()

    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18, weight: .medium)
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: " password",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        )
        textField.textAlignment = .left
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = .init(red: 156, green: 156, blue: 156, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.leftViewMode = .always
        return textField
    }()

    lazy var logOutLabel: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.text = "Cerrar Sesión"
        title.textAlignment = .center
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 16)
        title.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(logOutLabelTapped))
        title.addGestureRecognizer(tapGesture)
        return title
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.color = .black
        return activity
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .infoDark)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.setTitle("Guardar", for: .normal)
        return button
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
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, let surName = surNameTextField.text,
                let email = emailTextField.text, let phoneNumber = phoneNumberTextField.text,
                let password = passwordTextField.text else {
            return
        }
        let newUser = NewUserEntity(name: name, surName: surName, email: email,
                                    phoneNumber: phoneNumber, password: password, imageProfile: "")

        DispatchQueue.main.async {
            self.presenter?.updateUserData(user: newUser)
        }
    }
    
    @objc func logOutLabelTapped() {
        view.backgroundColor = .lightGray
        view.layer.opacity = 0.3
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.activityIndicator.stopAnimating()
            self.presenter?.goToLogin()
        }
    }
    
    func start() {
        setupView()
        DispatchQueue.main.async {
            self.presenter?.fetchUserData()
        }
    }
    
    func setupView() {
        view.addSubview(scrollHome)
        scrollHome.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(profileImage)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(phoneNumberTextField)
        containerView.addSubview(nameTextField)
        containerView.addSubview(surNameTextField)
        containerView.addSubview(logOutLabel)
        containerView.addSubview(activityIndicator)
        containerView.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        surNameTextField.translatesAutoresizingMaskIntoConstraints = false
        logOutLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            
            profileImage.heightAnchor.constraint(equalToConstant: 200),
            profileImage.widthAnchor.constraint(equalToConstant: 200),
            profileImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            
            nameTextField.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            nameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            surNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            surNameTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            surNameTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            surNameTextField.heightAnchor.constraint(equalToConstant: 40),

            phoneNumberTextField.topAnchor.constraint(equalTo: surNameTextField.bottomAnchor, constant: 20),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),

            emailTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            logOutLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            logOutLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            logOutLabel.widthAnchor.constraint(equalToConstant: 200),
            logOutLabel.heightAnchor.constraint(equalToConstant: 40),
            
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: logOutLabel.bottomAnchor, constant: 5),
            saveButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        DispatchQueue.main.async {
            self.profileImage.layoutIfNeeded()
            self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
            self.profileImage.clipsToBounds = true
        }
    }
        
    @objc func tappableProfilePicture() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        self.present(picker, animated: true)
    }
        
}


extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            self.profileImage.image = image
        }
        
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

}

extension SettingsViewController: SettingsViewProtocol {
    
    func fetchUserData(data: NewUserEntity) {
        self.nameTextField.text = data.name
        self.surNameTextField.text = data.surName
        self.emailTextField.text = data.email
        self.phoneNumberTextField.text = data.phoneNumber
        guard let image = data.imageProfile else { return }
        let url = URL(string: image)
        self.profileImage.kf.setImage(with: url)
    }

    func errorPopUp(title: String, message: String) {
        self.showErrorPopUp(title: title, message: message)
    }
    
    func updateUserData(dataUser: NewUserEntity) {
        self.nameTextField.text = dataUser.name
        self.surNameTextField.text = dataUser.surName
        self.emailTextField.text = dataUser.email
        self.phoneNumberTextField.text = dataUser.phoneNumber
        guard let image = dataUser.imageProfile else { return }
        let url = URL(string: image)
        self.profileImage.kf.setImage(with: url)
    }

}
