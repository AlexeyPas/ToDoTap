//
//  AccountViewController.swift
//  ToDoTap
//
//  Created by Pasynkov Alexey on 10.06.2021.
//  
//

import UIKit
import PinLayout
import Firebase

final class AccountViewController: UIViewController {
	private let output: AccountViewOutput

    init(output: AccountViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
        setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Выйти", style: .done, target: self, action: #selector(self.didTapAddExitButton(sender: )))
//        (barButtonSystemItem: .cancel, target: self, action: #selector(self.didTapAddExitButton()))
	}
    
    var photoImage = UIImageView()
    fileprivate let nameLabel = UILabel()
    private let conteinerView = UIView()
    private let backWindow = UIImageView(image: UIImage(named: "backWindow"))
    fileprivate let tasksLabel = UILabel()

    private func setup() {
    
        nameLabel.text = "Имя: Alex"
        nameLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        
        tasksLabel.text = "Point"
        tasksLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        
        [nameLabel].forEach{conteinerView.addSubview($0)}
        
        [backWindow, conteinerView].forEach { view.addSubview($0)}
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backWindow.pin
            .center()
        
        conteinerView.pin
            .horizontally(24)
        
        nameLabel.pin
            .top()
            .sizeToFit()
            .hCenter()
       
        tasksLabel.pin
            .below(of: nameLabel, aligned: .center)
            .marginTop(26)
            .height(48)
            .width(90%)
            .maxWidth(250)
            .sizeToFit()
        
        conteinerView.pin
            .wrapContent(.vertically)
            .center()
    }
    
    @objc
    private func didTapAddExitButton(sender: UIBarButtonItem) {
        output.onLogoutTapped()
    }
}

extension AccountViewController: AccountViewInput {
    func showError(message: String) {
        let ac = UIAlertController(title: "ВНИМАНИЕ", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(okAction)
        ac.view.backgroundColor = .gray
        ac.view.tintColor = .black
        self.present(ac, animated: true, completion: nil)
    }
}
