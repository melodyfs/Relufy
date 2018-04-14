//
//  LoginVC.swift
//  Mentor-iOS
//
//  Created by Melody on 4/6/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift

class LoginVC: UIViewController {
    
    lazy var appDelegate = AppDelegateViewModel.instance
    lazy var keys = AppKeys.instance
    let keychain = KeychainSwift()
    let networking = ServerNetworking.shared
    let userDefault = UserDefaults.standard
    
    let logInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.addBorder(color: UIColor.white)
        button.makeRounded()
        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        return button
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        var myMutableStringTitle = NSMutableAttributedString()
        let title  = "email"
        myMutableStringTitle = NSMutableAttributedString(string:title, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 20)])
        myMutableStringTitle.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white.withAlphaComponent(0.6), range:NSRange(location:0,length:title.characters.count))
        textField.attributedPlaceholder = myMutableStringTitle
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textColor = UIColor.white
        textField.backgroundColor = UIColor.clear
        textField.keyboardType = UIKeyboardType.emailAddress
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        let title  = "password"
        var myMutableStringTitle = NSMutableAttributedString()
        myMutableStringTitle = NSMutableAttributedString(string:title, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 20)]) // Font
        myMutableStringTitle.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white.withAlphaComponent(0.6), range:NSRange(location:0,length:title.characters.count))
        textField.attributedPlaceholder = myMutableStringTitle
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textColor = UIColor.white
        textField.backgroundColor = UIColor.clear
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.violetBlue
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.addBorder(color: UIColor.white)
        button.makeRounded()
        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        return button
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "empty")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    @objc func touchDown(sender: UIButton) {
        sender.backgroundColor = UIColor.white
        sender.setTitleColor(UIColor.violetBlue, for: UIControlState.normal)
    }
   
    @objc func handleLogin(sender: UIButton) {
        setKeychainCredential()
        let email = keychain.get("email")!
        let password = keychain.get("password")!
        
        let user = ["email": email, "password": password]
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        if keys.isMentor {
            networking.getInfo(route: .getMentor, params: user) { data in
                if let list = try? JSONDecoder().decode(User.self, from: data) {
                    self.keychain.set((list.token)!, forKey: "token")
                    self.keychain.set(String((list.id)!), forKey: "id")
                    DispatchQueue.main.async {
                        if self.networking.statusCode != 200{
                            self.informSignUpFailure()
                            self.unauthorize()
                            UIViewController.removeSpinner(spinner: sv)
                        } else {
                            self.authorize()
                            UIViewController.removeSpinner(spinner: sv)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.informSignUpFailure()
                        UIViewController.removeSpinner(spinner: sv)
                        self.unauthorize()
                    }
                }
               
            }
        } else {
            keys.setMentorOrMentee(isMentor: false)
            networking.getInfo(route: .getMentee, params: user) { data in
                if let list = try? JSONDecoder().decode(User.self, from: data) {
                    self.keychain.set((list.token)!, forKey: "token")
                    self.keychain.set(String((list.id)!), forKey: "id")
                    DispatchQueue.main.async {
                        if self.networking.statusCode != 200 {
                            self.informSignUpFailure()
                            UIViewController.removeSpinner(spinner: sv)
                            self.unauthorize()
                        } else {
                            self.authorize()
                            UIViewController.removeSpinner(spinner: sv)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.informSignUpFailure()
                        UIViewController.removeSpinner(spinner: sv)
                        self.unauthorize()
                    }
                    
                }
               
            }
        }
    }
    
    @objc func handleSignUp() {
        setKeychainCredential()
        let email = keychain.get("email")!
        let password = keychain.get("password")!
        
        let user = ["email": email, "password": password]
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        if keys.isMentor {
            keys.setMentorOrMentee(isMentor: true)
            networking.getInfo(route: .createMentor, params: user) { data in
                let list = try? JSONDecoder().decode(User.self, from: data)
                
                 DispatchQueue.main.async {
                    if self.networking.statusCode != 201 {
                        self.informSignUpFailure()
                        UIViewController.removeSpinner(spinner: sv)
                        self.unauthorize()
                    } else {
                        self.keychain.set((list?.token)!, forKey: "token")
                        self.keychain.set(String((list?.id)!), forKey: "id")
                        UIViewController.removeSpinner(spinner: sv)
                        self.authorize()
                    }
                }
            }
        } else {
            keys.setMentorOrMentee(isMentor: false)
            networking.getInfo(route: .createMentee, params: user) { data in
                let list = try? JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    if self.networking.statusCode != 201 {
                        self.informSignUpFailure()
                        UIViewController.removeSpinner(spinner: sv)
                        self.unauthorize()
                    } else {
                        self.keychain.set((list?.token)!, forKey: "token")
                        self.keychain.set(String((list?.id)!), forKey: "id")
                        UIViewController.removeSpinner(spinner: sv)
                        self.authorize()
                    }
                }
            }
        }
        
    }
    
    func setKeychainCredential() {
        keychain.set(emailTextField.text!, forKey: "email")
        keychain.set(passwordTextField.text!, forKey: "password")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    override func viewDidLayoutSubviews() {
        let lineColor = UIColor.white
        self.emailTextField.setBottomLine(borderColor: lineColor)
        self.passwordTextField.setBottomLine(borderColor: lineColor)
        
    }
    
    func informLoginFailure() {
        let alertController = UIAlertController(title: "Login Failed", message: "Wrong email or password", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(ok)
        self.present(alertController, animated: true) { () in
            
        }
    }
    
    func informSignUpFailure() {
        let alertController = UIAlertController(title: "Email already exists", message: "Use other email", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(ok)
        self.present(alertController, animated: true) { () in
        }
    }
    
    
    func setUpViews() {
        view.addSubview(iconImageView)
        view.addSubview(logInButton)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -180).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true

       
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80).isActive = true
        logInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150).isActive = true
        logInButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor, constant: 70).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80).isActive = true
        signUpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func authorize() {
        appDelegate.changeStatus(authStatus: .authorized)
    }
    
    func unauthorize() {
        appDelegate.changeStatus(authStatus: .unauthorized)
    }
}

