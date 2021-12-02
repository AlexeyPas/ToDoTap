//
//  AccountViewController_v.swift
//  HookahProject
//
//  Created by Nikita Kuznetsov on 15.12.2020.
//

import UIKit
import PinLayout

class AccountViewController_v: UIViewController {
    

    
    private let presenter: AccountViewOutput
    
    private let conteinerView = UIView()
    private let backWindow = UIImageView(image: UIImage(named: "backWindow"))
    private let textHidan = UILabel()
    private let actionButton = UIButton()
    private let emailTextField = UITextField()
    private let passwordWindow = UITextField()
    private let buttonRegister = UIButton()
    private let buttinForgot = UIButton()

//    weak var navigationControllerProvider: UIViewController?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.checkSession()
        setup()
    }

    @objc
    private func didTapActionButton() {
        let email = emailTextField.text ?? ""
        let password = passwordWindow.text ?? ""
        
        presenter.Account(data: AccountAndPasswordData(Account: email, password: password))
    }
    
    @objc
    private func didTapRegisterButton() {
        presenter.register()
    }
    
    private func setup() {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let paddingView2: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let paddingView3: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        actionButton.layer.cornerRadius = 20
        actionButton.layer.masksToBounds = true
        actionButton.backgroundColor = UIColor.blue
        actionButton.setTitle("->", for: .normal)
        
        textHidan.text = "Account"
        textHidan.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        
        buttonRegister.setTitle("Register", for: .normal)
        buttonRegister.backgroundColor = UIColor(white: 1, alpha: 0.7)
        buttonRegister.layer.cornerRadius = 12
        buttonRegister.layer.masksToBounds = true
        buttonRegister.setTitleColor(.black, for: .normal)
        buttonRegister.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        buttinForgot.setTitle("Forgot?", for: .normal)
        buttinForgot.setTitleColor(.black, for: .normal)
        buttinForgot.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttinForgot.alpha = 0.3
        
        emailTextField.placeholder = "Email"
        emailTextField.backgroundColor = UIColor(white: 1, alpha: 0.7)
        emailTextField.layer.cornerRadius = 20
        emailTextField.layer.masksToBounds = true
        emailTextField.leftView = paddingView2
        emailTextField.leftViewMode = .always
//        emailTextField.inputAccessoryView = tooldar
        
        
        passwordWindow.placeholder = "Password"
        passwordWindow.backgroundColor = UIColor(white: 1, alpha: 0.7)
        passwordWindow.layer.cornerRadius = 20
        passwordWindow.layer.masksToBounds = true
        passwordWindow.leftView = paddingView
        passwordWindow.leftViewMode = .always
        passwordWindow.isSecureTextEntry = true
        
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        
        buttonRegister.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        
        [textHidan, emailTextField, passwordWindow, actionButton].forEach{conteinerView.addSubview($0)}
        
        [backWindow, conteinerView, buttonRegister, buttinForgot].forEach { view.addSubview($0)}
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backWindow.pin
            .center()
        
        conteinerView.pin
            .horizontally(24)
        
        textHidan.pin
            .top()
            .sizeToFit()
            .hCenter()
       
        emailTextField.pin
            .below(of: textHidan, aligned: .center)
            .marginTop(26)
            .height(48)
            .width(90%)
            .maxWidth(250)

        passwordWindow.pin
            .below(of: emailTextField, aligned: .center)
            .marginTop(12)
            .height(48)
            .width(90%)
            .maxWidth(250)
        
        actionButton.pin
            .below(of: passwordWindow, aligned: .center)
            .marginTop(12)
            .height(48)
            .width(90%)
            .maxWidth(250)
        
        
        buttonRegister.pin
            .topRight(view.pin.safeArea.top)
            .height(48)
            .width(120)
        
        buttinForgot.pin
            .bottomLeft(24)
            //.marginLeft(12)
            .height(48)
            .width(120)
        
        conteinerView.pin
            .wrapContent(.vertically)
            .center()
    }
    
    
    init(output: AccountViewOutput) {
        self.presenter = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountViewController_v: AccountViewInput{
    func showError(message: String) {
        let ac = UIAlertController(title: "ВНИМАНИЕ", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(okAction)
        ac.view.backgroundColor = .gray
        ac.view.tintColor = .black
        self.present(ac, animated: true, completion: nil)
    }
}

private extension AccountViewController_v{
//    @objc
//    func onSubmitTap(){
//        let data = segmentView.extractData()
//        presenter.Account(email: EmailView, password: )
//    }
    @objc
    func onRegisterTap(){
        presenter.register()
    }
    @objc
    func onForgorPassTap(){
        //do something...
    }
}

protocol ViewToController: class{
    func updateButtonsStatus()
}

extension AccountViewController_v: ViewToController{
    func updateButtonsStatus() {
//        if segmentView.checkValidation(){
//            signInButton.alpha = 1
//            signInButton.isEnabled = true
//        }
//        else{
//            signInButton.alpha = 0.4
//            signInButton.isEnabled = false
//        }
    }
}
