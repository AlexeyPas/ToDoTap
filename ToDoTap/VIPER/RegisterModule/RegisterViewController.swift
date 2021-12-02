//
//  RegisterViewController.swift
//  HookahProject
//
//  Created by Nikita Kuznetsov on 28.12.2020.
//

import UIKit
import PinLayout

final class RegisterViewController: UIViewController {
    let presenter: RegisterViewOutput
    
    private let conteinerView = UIView()
    private let backWindow = UIImageView(image: UIImage(named: "backWindow"))
    private let textHidan = UILabel()
    private let actionButton = UIButton()
    private let usernameWindow = RegisterFieldView()
    private let passwordWindow = RegisterFieldView()
    private let emailWindow = RegisterFieldView()
    private let phoneNumberWindow = RegisterFieldView()
    private let buttonLogin = UIButton()
    
    private func setup() {
        setupLable()
        setupField()
        setupButton()

        [textHidan, usernameWindow, emailWindow, passwordWindow, phoneNumberWindow, actionButton].forEach{conteinerView.addSubview($0)}
        [backWindow, conteinerView, buttonLogin].forEach { view.addSubview($0)}
        
    }
    
    private func setupLable() {
        textHidan.text = "Register"
        textHidan.font = UIFont.systemFont(ofSize: 36, weight: .bold)
    }
    
    private func setupButton() {
        actionButton.layer.cornerRadius = 20
        actionButton.layer.masksToBounds = true
        actionButton.backgroundColor = UIColor.blue
        actionButton.setTitle("->", for: .normal)
        
        buttonLogin.setTitle("Login", for: .normal)
        buttonLogin.backgroundColor = UIColor(white: 1, alpha: 0.7)
        buttonLogin.layer.cornerRadius = 12
        buttonLogin.layer.masksToBounds = true
        buttonLogin.setTitleColor(.black, for: .normal)
        buttonLogin.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        actionButton.addTarget(self, action: #selector(onSubmitTap), for: .touchUpInside)
        
        buttonLogin.addTarget(self, action: #selector(onLoginTap), for: .touchUpInside)
    }
    private func setupField() {

        usernameWindow.backgroundColor = UIColor(white: 1, alpha: 0.7)
        usernameWindow.layer.cornerRadius = 20
        usernameWindow.layer.masksToBounds = true
        usernameWindow.setInputAttrs(imageName: "account", placeholderText: "Имя")

        passwordWindow.backgroundColor = UIColor(white: 1, alpha: 0.7)
        passwordWindow.layer.cornerRadius = 20
        passwordWindow.layer.masksToBounds = true
        passwordWindow.setInputAttrs(imageName: "password", placeholderText: "Пароль ")
        
        emailWindow.backgroundColor = UIColor(white: 1, alpha: 0.7)
        emailWindow.layer.cornerRadius = 20
        emailWindow.layer.masksToBounds = true
        emailWindow.setInputAttrs(imageName: "mail", placeholderText: "Электронная почта")
        
        phoneNumberWindow.backgroundColor = UIColor(white: 1, alpha: 0.7)
        phoneNumberWindow.layer.cornerRadius = 20
        phoneNumberWindow.layer.masksToBounds = true
        phoneNumberWindow.setInputAttrs(imageName: "phone", placeholderText: "Телефон ")
        phoneNumberWindow.textFieldView.textField.keyboardType = .phonePad
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        backWindow.pin.center()
        
        conteinerView.pin
            .horizontally(24)
        
        textHidan.pin
            .top()
            .sizeToFit()
            .hCenter()
        
        usernameWindow.pin
            .below(of: textHidan, aligned: .center)
            .marginTop(36)
            .height(48)
            .width(90%)
            .maxWidth(250)
        
        emailWindow.pin
            .below(of: usernameWindow, aligned: .center)
            .marginTop(12)
            .height(48)
            .width(90%)
            .maxWidth(250)

        passwordWindow.pin
            .below(of: emailWindow, aligned: .center)
            .marginTop(12)
            .height(48)
            .width(90%)
            .maxWidth(250)
        
        phoneNumberWindow.pin
            .below(of: passwordWindow, aligned: .center)
            .marginTop(12)
            .height(48)
            .width(90%)
            .maxWidth(250)
        
        actionButton.pin
            .below(of: phoneNumberWindow, aligned: .center)
            .marginTop(12)
            .height(48)
            .width(90%)
            .maxWidth(250)
        
        buttonLogin.pin
            .topRight()
            .marginTop(100)
            .marginRight(12)
            .height(48)
            .width(120)
        
        conteinerView.pin
            .wrapContent(.vertically)
            .center()
    }

    init(output: RegisterViewOutput) {
        self.presenter = output
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        self.hideKeyboard()
    }
}

private extension RegisterViewController{
    @objc
    func onSubmitTap() {
        presenter.onRegisterTapped(data: [usernameWindow, emailWindow, phoneNumberWindow, passwordWindow])
    }
    
    @objc
    func onLoginTap() {
        dismiss(animated: true, completion: nil)
    }
}

extension RegisterViewController: RegisterViewInput{
    func showError(errorResults: [FailureResult]) {
        for item in errorResults{
            item.source?.displayError(message: item.errorMessage)
        }
    }
    
    func getDataFromView() -> RegisterData {
        return RegisterData(fio: usernameWindow.getContent(), email: emailWindow.getContent(), phoneNumber: phoneNumberWindow.getContent(), pass: passwordWindow.getContent())
    }
}
