//
//  RegisterView.swift
//  AppPapple
//
//  Created by Christian Morante on 6/01/25.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let router = RegisterRouter()
    let presenter = RegisterPresenter()
    
    lazy var successButton: UIButton = {
        let button = UIButton()
        button.setTitle("Crear", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = button.frame.size.width / 2
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(register), for: .touchUpInside)
        return button
    }()
        
    lazy var titleRegisterLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "Empecemos!"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    lazy var descriptionRegisterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .justified
        label.text = "Créate una cuenta en nuestra app"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    lazy var registerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "registerImage")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.textColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        return textField
    }()
    
    lazy var surNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Sur Name"
        textField.textColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        return textField
    }()
        
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.textColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        return textField
    }()
    
    lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone Number"
        textField.textColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.textColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var passwordConfirmTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm Password"
        textField.textColor = .darkGray
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 210/255.0, green: 105/255.0, blue: 30/255.0, alpha: 1)
        view.addSubview(successButton)
        view.addSubview(titleRegisterLabel)
        view.addSubview(descriptionRegisterLabel)
        view.addSubview(registerImage)
        view.addSubview(nameField)
        view.addSubview(surNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordConfirmTextField)
        setupConstraints()
    }
    
    func setupConstraints() {
        successButton.translatesAutoresizingMaskIntoConstraints = false
        titleRegisterLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionRegisterLabel.translatesAutoresizingMaskIntoConstraints = false
        registerImage.translatesAutoresizingMaskIntoConstraints = false
        nameField.translatesAutoresizingMaskIntoConstraints = false
        surNameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordConfirmTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleRegisterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleRegisterLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleRegisterLabel.widthAnchor.constraint(equalToConstant: 200),
            
            registerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerImage.topAnchor.constraint(equalTo: titleRegisterLabel.bottomAnchor, constant: 20),
            registerImage.heightAnchor.constraint(equalToConstant: 200),
            
            descriptionRegisterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionRegisterLabel.topAnchor.constraint(equalTo: registerImage.bottomAnchor, constant: 20),
            descriptionRegisterLabel.widthAnchor.constraint(equalToConstant: 300),
            
            nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameField.topAnchor.constraint(equalTo: descriptionRegisterLabel.bottomAnchor, constant: 20),
            nameField.widthAnchor.constraint(equalToConstant: 200),
            
            surNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            surNameTextField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 30),
            surNameTextField.widthAnchor.constraint(equalToConstant: 200),

            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: surNameTextField.bottomAnchor, constant: 30),
            emailTextField.widthAnchor.constraint(equalToConstant: 200),

            phoneNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneNumberTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            phoneNumberTextField.widthAnchor.constraint(equalToConstant: 200),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 30),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),

            passwordConfirmTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordConfirmTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            passwordConfirmTextField.widthAnchor.constraint(equalToConstant: 200),

            
            successButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successButton.topAnchor.constraint(equalTo: passwordConfirmTextField.bottomAnchor, constant: 20),
            successButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func register() {
        let newUser = NewUserEntity(name: nameField.text!, surname: surNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, phoneNumber: phoneNumberTextField.text!)
        
        presenter.registerUser(user: newUser)
        router.goToLogin(mainView: self)
    }
}
