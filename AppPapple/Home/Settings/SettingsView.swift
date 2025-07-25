//
//  SettingsView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//

import UIKit
import Kingfisher

class SettingsView: UIView {
    
    var presenter: HomePresenter?
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.text = "My account"
        title.textAlignment = .center
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        return title
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
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = .init(red: 0, green: 0, blue: 255, alpha: 1)
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
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = .init(red: 0, green: 0, blue: 255, alpha: 1)
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
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = .init(red: 0, green: 0, blue: 255, alpha: 1)
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
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = .init(red: 0, green: 0, blue: 255, alpha: 1)
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
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = .init(red: 0, green: 0, blue: 255, alpha: 1)
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
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
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
    
    func start() {
        setupView()
        DispatchQueue.main.async {
            self.presenter?.fetchUserData()
        }
    }
    
    func setupView() {
        self.addSubview(title)
        self.addSubview(profileImage)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(phoneNumberTextField)
        self.addSubview(nameTextField)
        self.addSubview(surNameTextField)
        self.addSubview(logOutLabel)
        self.addSubview(activityIndicator)
        self.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)

        title.translatesAutoresizingMaskIntoConstraints = false
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
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            title.widthAnchor.constraint(equalToConstant: 200),
            
            profileImage.heightAnchor.constraint(equalToConstant: 200),
            profileImage.widthAnchor.constraint(equalToConstant: 200),
            profileImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            
            nameTextField.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            nameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 200),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            surNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            surNameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            surNameTextField.widthAnchor.constraint(equalToConstant: 200),
            surNameTextField.heightAnchor.constraint(equalToConstant: 40),

            phoneNumberTextField.topAnchor.constraint(equalTo: surNameTextField.bottomAnchor, constant: 20),
            phoneNumberTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            phoneNumberTextField.widthAnchor.constraint(equalToConstant: 200),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),

            emailTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 200),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            logOutLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            logOutLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logOutLabel.widthAnchor.constraint(equalToConstant: 200),
            logOutLabel.heightAnchor.constraint(equalToConstant: 40),
            
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: logOutLabel.bottomAnchor, constant: 5)
            
        ])
        DispatchQueue.main.async {
            self.profileImage.layoutIfNeeded()
            self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
            self.profileImage.clipsToBounds = true
        }
        backgroundColor = .red
    }
    
    @objc func logOutLabelTapped() {
        self.backgroundColor = .lightGray
        self.layer.opacity = 0.3
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.activityIndicator.stopAnimating()
            self.presenter?.goToLogin()
        }
    }
    
    @objc func tappableProfilePicture() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        if let viewController = self.parentViewController() {
            viewController.present(picker, animated: true)
        }
    }
    
    func showErrorPopUp(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        guard let viewController = self.parentViewController() else {
            return
        }
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}


extension SettingsView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension UIView {
    func parentViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let vc = nextResponder as? UIViewController {
                return vc
            }
            responder = nextResponder
        }
        return nil
    }
}

extension SettingsView: SettingsViewProtocol {
    
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
