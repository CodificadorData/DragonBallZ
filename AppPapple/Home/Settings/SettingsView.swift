//
//  SettingsView.swift
//  AppPapple
//
//  Created by Christian Morante on 20/01/25.
//

import UIKit

class SettingsView: UIView {
    
    let router = HomeRouter()
//    var viewController: HomeViewController?
    let presenter = SettingsPresenter(interactor: SettingsInteractor())
    
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

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(/*view: HomeViewController*/) {
        super.init(frame: .zero)
//        self.viewController = view
        self.start(/*view: view*/)
    }
    
    func start(/*view: HomeViewController*/) {
        setupView(/*view: view.view*/)
        self.presenter.fetchSettings { dataJson in
            self.nameTextField.text = dataJson.name
            self.surNameTextField.text = dataJson.surName
            self.emailTextField.text = dataJson.email
            self.phoneNumberTextField.text = dataJson.phoneNumber
            let cleanedBase64 = dataJson.imageProfile?
                    .replacingOccurrences(of: "data:image/png;base64,", with: "")
                    .replacingOccurrences(of: "data:image/jpeg;base64,", with: "") // por si es JPG
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                
            if let imageData = Data(base64Encoded: cleanedBase64!),
                let image = UIImage(data: imageData) {
                self.profileImage.image = image
            }
        }
        self.presenter.updateUserData(name: "Alex", surName: "Dino", phoneNumber: "321123321", email: "1234", imageProfile: "1", password: "1234") { dataJson in
            switch dataJson {
            case .success(let dataJson):
                print("success")
            case .failure(let error):
                print("error")
            }
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
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)

        ])
        DispatchQueue.main.async {
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
//            self.router.goToLogin(windows: self.viewController!.view.window)
        }
    }
    
    @objc func tappableProfilePicture() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
//        viewController?.present(picker, animated: true)
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
