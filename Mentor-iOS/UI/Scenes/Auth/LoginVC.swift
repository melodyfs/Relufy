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
import DropDown

class LoginVC: UIViewController {
    
    lazy var appDelegate = AppDelegateViewModel.instance
    lazy var keys = AppKeys.instance
    let keychain = KeychainSwift()
    let networking = ServerNetworking.shared
    let userDefault = UserDefaults.standard
    let mentorOrMenteeDropdown = DropDown()
    
    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(UIColor.violetBlue, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.backgroundColor = UIColor.white
        button.addBorder(color: UIColor.white)
        button.makeRounded()
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
        myMutableStringTitle = NSMutableAttributedString(string:title, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 20)]) 
        myMutableStringTitle.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white.withAlphaComponent(0.6), range:NSRange(location:0,length:title.characters.count))
        textField.attributedPlaceholder = myMutableStringTitle
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textColor = UIColor.white
        textField.backgroundColor = UIColor.clear
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "dismiss-w"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
//        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        return button
    }()
    
    @objc func handleDismiss() {
        print("dismiss")
        dismiss(animated: true, completion: {
            AppDelegateViewModel.instance.changeStatus(authStatus: .unauthorized)
        })
    }
    
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "empty")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    let mentorOrMenteeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "I was ..."
        return label
    }()
    
    let mentorOrMenteeTextView: UILabel = {
        let textView = UILabel()
        textView.font = UIFont.systemFont(ofSize: 22)
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.isUserInteractionEnabled = false
        textView.contentMode = .bottom
        return textView
    }()
    
    let mentorMenteeDropButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("select", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleMentorMenteeDrop), for: .touchUpInside)
        return button
    }()
    
    @objc func handleMentorMenteeDrop() {
        mentorOrMenteeDropdown.show()
        
    }
   
    @objc func handleLogin(sender: UIButton) {
        
        setKeychainCredential()
        
        let email = keychain.get("email")!
        let password = keychain.get("password")!
        
        let user = ["email": email, "password": password]
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        networking.getInfo(route: .getMentor, params: user) { data in
            if let list = try? JSONDecoder().decode(User.self, from: data) {
                print(list)
                self.keychain.set((list.token)!, forKey: "token-mentor")
                self.keychain.set(String((list.id)!), forKey: "id-mentor")
            }
        }
        
        networking.getInfo(route: .getMentee, params: user) { data in
            if let list = try? JSONDecoder().decode(User.self, from: data) {
                self.keychain.set((list.token)!, forKey: "token")
                self.keychain.set(String((list.id)!), forKey: "id")
                token = (list.token)!
                userID = String((list.id)!)
                DispatchQueue.main.async {
                    if self.networking.statusCode != 200 {
                        self.informLoginFailure()
                        UIViewController.removeSpinner(spinner: sv)
//                            self.unauthorize()
                    } else {
                        self.setMentorOrMentee()
                        self.authorize()
                        UIViewController.removeSpinner(spinner: sv)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.informLoginFailure()
                    UIViewController.removeSpinner(spinner: sv)
//                        self.unauthorize()
                }
                
            }
           
        }
       
    
    }
    
    func setMentorOrMentee() {
        keys.setMentorOrMentee(isMentor: false)
    }
    
    func setKeychainCredential() {
        keychain.set(emailTextField.text!, forKey: "email")
        keychain.set(passwordTextField.text!, forKey: "password")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        mentorOrMenteeDropdown.anchorView = mentorOrMenteeTextView
        mentorOrMenteeDropdown.dataSource = ["giving advice", "receiving advice"]
        mentorOrMenteeDropdown.selectionAction = { [weak self] (index, item) in
            self?.mentorOrMenteeTextView.text = item
        }
    }
    
    override func viewDidLayoutSubviews() {
        let lineColor = UIColor.white
        self.emailTextField.setBottomLine(borderColor: lineColor)
        self.passwordTextField.setBottomLine(borderColor: lineColor)
        self.mentorOrMenteeTextView.layer.addBorder(edge: .bottom, color: lineColor, thickness: 0.8)
    }
    
    func informLoginFailure() {
        let alertController = UIAlertController(title: "Login Failed", message: "Wrong email or password", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(ok)
        self.present(alertController, animated: true) { () in
            
        }
    }
    
    deinit {
        print("login deinit")
    }
    
    func setUpViews() {
        view.addSubview(logInButton)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(dismissButton)

        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 220).isActive = true
        logInButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -140).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor, constant: 80).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        dismissButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func authorize() {
        appDelegate.changeStatus(authStatus: .authorized)
    }
    
    func unauthorize() {
        self.dismiss(animated: true, completion: nil)
    }
}

