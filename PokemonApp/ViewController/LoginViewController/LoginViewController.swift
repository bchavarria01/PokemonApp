//
//  LoginViewController.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 7/12/20.
//  Copyright © 2020 Byron Chavarría. All rights reserved.
//

import UIKit
import FirebaseAuth

final class LoginViewController: BaseViewController {
    
    // MARK: - Components
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.Base.player.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "mail@example.com"
        textField.keyboardType = .emailAddress
        textField.textContentType = .emailAddress
        return textField
    }()
    
    lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "*************"
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        return textField
    }()
    
    lazy var singInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sing In", for: .normal)
        button.backgroundColor = R.Colors.red.color
        return button
    }()
    
    lazy var singUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sing Up", for: .normal)
        button.backgroundColor = R.Colors.pokemonRed.color
        return button
    }()
    
    lazy var separator: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "<-------- or -------->"
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    
    lazy var facebookSignInBottom: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Facebook", for: .normal)
        button.backgroundColor = R.Colors.blue.color
        return button
    }()
    
    lazy var twitterSingIn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Twitter", for: .normal)
        button.backgroundColor = R.Colors.pokemonBlue.color
        return button
    }()
    
    // MARK: - Attributes
    
    var handle: NSObjectProtocol?
    weak var delegate: LoginViewControllerDelegate?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupActions()
        hideKeyboardGesture()
        setupKeyboardHandling()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    // MARK: - Helpers
    
    private func setupKeyboardHandling() {
        subscribeForKeyboardChange(
            self,
            selector: #selector(keyboardWillChange(_:))
        )
    }
    
    @objc private func keyboardWillChange(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            else { return }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else if notification.name == UIResponder.keyboardWillShowNotification {
            scrollView.contentInset.bottom = frame.height
        }
    }
    
    private func setupActions() {
        singInButton.addTarget(self, action: #selector(singIn), for: .touchUpInside)
    }
    
    private func setupLayout() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImage)
        contentView.addSubview(emailField)
        contentView.addSubview(passwordField)
        contentView.addSubview(singInButton)
        contentView.addSubview(singUpButton)
        contentView.addSubview(separator)
        contentView.addSubview(facebookSignInBottom)
        contentView.addSubview(twitterSingIn)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            logoImage.widthAnchor.constraint(equalToConstant: 210),
            logoImage.heightAnchor.constraint(equalToConstant: 240),
            
            emailField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 16),
            emailField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            emailField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 8),
            passwordField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            passwordField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            singInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            singInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            singInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            singInButton.widthAnchor.constraint(equalToConstant: 50),
            
            singUpButton.topAnchor.constraint(equalTo: singInButton.bottomAnchor, constant: 4),
            singUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            singUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            singUpButton.widthAnchor.constraint(equalToConstant: 50),
            
            separator.topAnchor.constraint(equalTo: singUpButton.bottomAnchor, constant: 4),
            separator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            facebookSignInBottom.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 16),
            facebookSignInBottom.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            facebookSignInBottom.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            facebookSignInBottom.widthAnchor.constraint(equalToConstant: 50),
            
            twitterSingIn.topAnchor.constraint(equalTo: facebookSignInBottom.bottomAnchor, constant: 4),
            twitterSingIn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            twitterSingIn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            twitterSingIn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            twitterSingIn.widthAnchor.constraint(equalToConstant: 50),
            
        ])
        
    }
    
    func createNewAccount(with email: String, and password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
        }
    }
    
    @objc func singIn() {
        Auth.auth().signIn(withEmail: emailField.text ?? "", password: passwordField.text ?? "") { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if error == nil {
                strongSelf.delegate?.loginViewControllerDidSingInSuccess()
            } else {
                strongSelf.showActionMessage(title: L10n.error, message: error?.localizedDescription ?? "")
            }
        }
    }
    
}
