//
//  OpenningVC.swift
//  Mentor-iOS
//
//  Created by Melody on 4/6/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

class OpenningVC: UIViewController {
    
    let keys = AppKeys.instance
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 38)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Relate"
        return label
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchDown), for: .touchUpInside)
        button.addBorder(color: UIColor.white)
        button.makeRounded()
        return button
    }()

    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        button.setTitleColor(UIColor.violetBlue, for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchDown), for: .touchUpInside)
        button.addBorder(color: UIColor.white)
        button.makeRounded()
        return button
    }()

   
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "whiteIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    
    @objc func touchDown(sender: UIButton) {
        sender.setTitleColor(UIColor.violetPurple, for: UIControlState.normal)
    }
    
    @objc func handleSignUp(sender: UIButton) {
        let signupVC = SignUpVC()
//        signupVC.modalTransitionStyle = .flipHorizontal
        self.present(signupVC, animated: true)
        
    }
    
    @objc func handleLogIn(sender: UIButton) {
        let loginVC = LoginVC()
        loginVC.modalTransitionStyle = .flipHorizontal
        self.present(loginVC, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
//        signUpOrLogIn(sender: signUpButton)
    }
    
    func setUpViews() {
        view.addSubview(titleLabel)
//        view.addSubview(optionLabel)
        view.addSubview(signUpButton)
        view.addSubview(logInButton)
//        view.addSubview(nextButton)
        view.addSubview(iconImageView)
        
        
        iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        
//        optionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        optionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
//
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 180).isActive = true
        logInButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
//        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 250).isActive = true
    }
    

    



}
