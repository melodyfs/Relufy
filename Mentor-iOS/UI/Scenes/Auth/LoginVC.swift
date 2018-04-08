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
        return button
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textColor = UIColor.white
        textField.backgroundColor = UIColor.clear
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textColor = UIColor.white
        textField.backgroundColor = UIColor.clear
        return textField
    }()
    
    let orLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "or"
        return label
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
   
    @objc func handleLogin() {
        setKeychainCredential()
        let email = keychain.get("email")!
        let password = keychain.get("password")!
        
        let user = ["email": email, "password": password]
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        if keys.isMentor {
            networking.getInfo(route: .getMentor, params: user) { data in
                let list = try? JSONDecoder().decode(User.self, from: data)
                self.keychain.set((list?.token)!, forKey: "token")
                self.keychain.set(String((list?.id)!), forKey: "id")
                DispatchQueue.main.async {
                    if self.networking.statusCode != 200 {
                        self.informSignUpFailure()
                        UIViewController.removeSpinner(spinner: sv)
                    } else {
                        self.authorize()
                        UIViewController.removeSpinner(spinner: sv)
                    }
                }
            }
        } else {
            keys.setMentorOrMentee(isMentor: false)
            networking.getInfo(route: .getMentee, params: user) { data in
                let list = try? JSONDecoder().decode(User.self, from: data)
                self.keychain.set((list?.token)!, forKey: "token")
                self.keychain.set(String((list?.id)!), forKey: "id")
                DispatchQueue.main.async {
                    if self.networking.statusCode != 200 {
                        self.informSignUpFailure()
                        UIViewController.removeSpinner(spinner: sv)
                    } else {
                        self.authorize()
                        UIViewController.removeSpinner(spinner: sv)
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
                self.keychain.set((list?.token)!, forKey: "token")
                self.keychain.set(String((list?.id)!), forKey: "id")
                 DispatchQueue.main.async {
                    if self.networking.statusCode != 201 {
                        self.informSignUpFailure()
                        UIViewController.removeSpinner(spinner: sv)
                    } else {
                        self.authorize()
                        UIViewController.removeSpinner(spinner: sv)
                    }
                }
            }
        } else {
            keys.setMentorOrMentee(isMentor: false)
            networking.getInfo(route: .createMentee, params: user) { data in
                let list = try? JSONDecoder().decode(User.self, from: data)
                self.keychain.set((list?.token)!, forKey: "token")
                self.keychain.set(String((list?.id)!), forKey: "id")
                DispatchQueue.main.async {
                    if self.networking.statusCode != 201 {
                        self.informSignUpFailure()
                        UIViewController.removeSpinner(spinner: sv)
                    } else {
                        self.authorize()
                        UIViewController.removeSpinner(spinner: sv)
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
        view.addSubview(logInButton)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(orLabel)
        view.addSubview(signUpButton)
       
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150).isActive = true
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor, constant: 70).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        orLabel.centerXAnchor.constraint(equalTo: logInButton.centerXAnchor).isActive = true
        orLabel.centerYAnchor.constraint(equalTo: logInButton.centerYAnchor, constant: 50).isActive = true
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.centerXAnchor.constraint(equalTo: orLabel.centerXAnchor).isActive = true
        signUpButton.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor, constant: 50).isActive = true
        
    }
    
    func authorize() {
        appDelegate.changeStatus(authStatus: .authorized)
    }
}

extension UITextField {
    
    func setBottomLine(borderColor: UIColor) {
        
        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
        
        let borderLine = UIView()
        let height = 1.0
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height)
        
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
    
}
