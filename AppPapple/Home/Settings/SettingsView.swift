//
//  SettingsView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//

import UIKit

class SettingsView: UIView {
    
    let router = HomeRouter()
    var viewController: UIViewController?
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.text = "My account"
        title.textAlignment = .center
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        return title
    }()
    
    lazy var profileView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 5
        view.layer.borderColor = .init(red: 0, green: 0, blue: 200, alpha: 1)
        return view
    }()
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "userImage")
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

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(view: UIViewController) {
        super.init(frame: .zero)
        self.viewController = view
        self.setupView(view: view.view)
    }
    
    func setupView(view: UIView) {
        
        view.addSubview(self)
        self.addSubview(title)
        self.addSubview(profileView)
        self.addSubview(emailTextField)
        self.addSubview(passwordTextField)
        self.addSubview(phoneNumberTextField)
        self.addSubview(nameTextField)
        self.addSubview(surNameTextField)
        self.addSubview(logOutLabel)
        profileView.addSubview(profileImage)
        self.addSubview(activityIndicator
        )
        self.translatesAutoresizingMaskIntoConstraints = false
        profileView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        surNameTextField.translatesAutoresizingMaskIntoConstraints = false
        logOutLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.widthAnchor.constraint(equalTo: view.widthAnchor),
            self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            title.widthAnchor.constraint(equalToConstant: 200),
            
            profileView.heightAnchor.constraint(equalToConstant: 200),
            profileView.widthAnchor.constraint(equalToConstant: 200),
            profileView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileView.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            
            profileImage.heightAnchor.constraint(equalToConstant: 180),
            profileImage.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            profileImage.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 20),
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
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)

        ])
        profileView.layer.cornerRadius = 100
        profileView.layer.masksToBounds = true

        backgroundColor = .red
    }
    
    @objc func logOutLabelTapped() {
        self.backgroundColor = .lightGray
        self.layer.opacity = 0.3
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.activityIndicator.stopAnimating()
            self.router.goToLogin(windows: self.viewController!.view.window)
        }
    }
    
    @objc func tappableProfilePicture() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        viewController?.present(picker, animated: true)
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
