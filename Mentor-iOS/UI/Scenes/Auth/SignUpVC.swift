//
//  SignUpVC.swift
//  Mentor-iOS
//
//  Created by Melody on 4/30/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit
import Photos
import KeychainSwift
import DropDown

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UITextViewDelegate {
    
    let picker = UIImagePickerController()
    let keys = AppKeys.instance
    var imageData: Data?
    let keychain = KeychainSwift()
    let networking = ServerNetworking.shared
    let appDelegate = AppDelegateViewModel.instance
    let genderDropdown = DropDown()
    let roleDropdown = DropDown()
    let raceDropdown = DropDown()
    let yearDropdown = DropDown()
    let mentorOrMenteeDropdown = DropDown()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        return label
    }()
    
    let nameTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        return label
    }()
    
    let emailTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
        textView.keyboardType = UIKeyboardType.emailAddress
        return textView
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password"
        return label
    }()
    
    let passwordTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Role"
        return label
    }()
    
    let forLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "For"
        return label
    }()
    
    let yearTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.lightGray
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
        textView.keyboardType = UIKeyboardType.numberPad
        textView.text = "0"
//        textView.toolbarPlaceholder = "0"
//        textView.placeholderText = "0"
        return textView
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "years"
        return label
    }()
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Company"
        return label
    }()
    
    
    let roleTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.isUserInteractionEnabled = false
        return textView
        
    }()
    
    let roleDropButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("select", for: .normal)
        button.setTitleColor(UIColor.violetBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 16)
        button.addTarget(self, action: #selector(handleRoleDrop), for: .touchUpInside)
        return button
    }()
    
    @objc func handleRoleDrop() {
        roleDropdown.show()
        
    }
    
    let mentorOrMenteeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "I want to ..."
        return label
    }()
    
    let mentorOrMenteeTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    let mentorMenteeDropButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("select", for: .normal)
        button.setTitleColor(UIColor.violetBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 16)
        button.addTarget(self, action: #selector(handleMentorMenteeDrop), for: .touchUpInside)
        return button
    }()
    
    @objc func handleMentorMenteeDrop() {
        mentorOrMenteeDropdown.show()
        
    }
    
    let companyTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.text = "Bio"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalTextView: UITextView = {
        let textView = UITextView()
        //        textView.text = "Goal textview"
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    let raceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.text = "Race"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let raceTextView: UITextView = {
        let textView = UITextView()
        //        textView.text = "race textview"
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.text = "Gender"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    let genderTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "profileImageHolder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    @objc func tapImage(tapGestureRecognizer: UITapGestureRecognizer) {
        openPhotoLibrary()
    }
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor.violetBlue, for: .normal)
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
//        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        return button
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "dismiss"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        return button
    }()
    
    let createLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.text = "Create Profile"
        label.contentMode = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genderDropButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("select", for: .normal)
        button.setTitleColor(UIColor.violetBlue, for: .normal)
        button.addTarget(self, action: #selector(handleGenderDrop), for: .touchUpInside)
        return button
    }()
    
    let raceDropButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("select", for: .normal)
        button.setTitleColor(UIColor.violetBlue, for: .normal)
        button.addTarget(self, action: #selector(handleRaceDrop), for: .touchUpInside)
        return button
    }()
    
    
    @objc func handleGenderDrop() {
        genderDropdown.show()
        
    }
    @objc func handleRaceDrop() {
        raceDropdown.show()
        
    }
    
    @objc func handleDismiss() {
        print("dismiss")
        dismiss(animated: true, completion: {
            AppDelegateViewModel.instance.changeStatus(authStatus: .unauthorized)
        })
    }
    
    @objc func touchDown(sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: UIControlState.normal)
    }
    
    @objc func handleSave() {
        print("save")
        setMentorOrMentee()
        checkEmptyFields()
        if eachFieldIsFilled {
            signUpUser()
        }
       
    }
    
    func setMentorOrMentee() {
//        if mentorOrMenteeTextView.text == "Give advice" {
//            keys.setMentorOrMentee(isMentor: true)
//        } else {
        keys.setMentorOrMentee(isMentor: false)
//        }
    }
    
    var eachFieldIsFilled = false
    
    func checkEmptyFields() {
        if nameTextView.text == "" || roleTextView.text == "" || yearTextView.text == "" ||
            goalTextView.text == "" || raceTextView.text == "" || genderTextView.text == "" ||
            emailTextView.text == "" || passwordTextView.text == "" {
            let alertController = UIAlertController(title: "Empty Fields", message: "Fill out all fields before moving forward!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(ok)
            self.present(alertController, animated: true) { () in
            }
        } else {
            eachFieldIsFilled = true
        }
    }
    
    func signUpUser() {
        setKeychainCredential()
        let params = collectedParams()
        let sv = UIViewController.displaySpinner(onView: self.view)
        
//        if keys.isMentor {
            networking.getInfo(route: .createMentor, params: params) { data in
                let list = try? JSONDecoder().decode(User.self, from: data)
                
                DispatchQueue.main.async {
                    if self.networking.statusCode != 201 {
//                        self.informSignUpFailure()
//                        UIViewController.removeSpinner(spinner: sv)
//                        self.unauthorize()
                    } else {
                        self.keychain.set((list?.token)!, forKey: "token-mentor")
                        self.keychain.set(String((list?.id)!), forKey: "id-mentor")
//                        UIViewController.removeSpinner(spinner: sv)
//                        self.authorize()
                    }
                }
            }
            
//            UploadImage.upload(route: .updateMentor,  imageData: imageData!)
//        } else {
            networking.getInfo(route: .createMentee, params: params) { data in
                let list = try? JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    if self.networking.statusCode != 201 {
                        self.informSignUpFailure()
                        UIViewController.removeSpinner(spinner: sv)
                        self.unauthorize()
                    } else {
                        self.keychain.set((list?.token)!, forKey: "token")
                        self.keychain.set(String((list?.id)!), forKey: "id")
                        token = (list?.token)!
                        userID = String((list?.id)!)
                        UIViewController.removeSpinner(spinner: sv)
                        self.authorize()
                    }
                }
            }
//            UploadImage.upload(route: .updateMentee,  imageData: imageData!)
//        }
    }
    
    func informSignUpFailure() {
        let alertController = UIAlertController(title: "Email already exists", message: "Use other email", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(ok)
        self.present(alertController, animated: true) { () in
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScrollView()
        view.backgroundColor = UIColor.white
        setUpViews()
        addGestureToProfileImageView()
        addBar()
        handleDropDowns()
        yearTextView.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if textView == yearTextView {
                textView.text = "0"
            }
            textView.textColor = UIColor.lightGray
        }
    }
    
    func addGestureToProfileImageView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
    }
    
    func handleDropDowns() {
        genderDropdown.anchorView = genderTextView
        genderDropdown.dataSource = ["Man", "Woman", "Other"]
        genderDropdown.selectionAction = { [weak self] (index, item) in
            self?.genderTextView.text = item
        }
        
        roleDropdown.anchorView = roleTextView
        roleDropdown.dataSource = ["Software Engineer", "Product Manager", "Designer", "Other"]
        roleDropdown.selectionAction = { [weak self] (index, item) in
            self?.roleTextView.text = item
        }
        
        raceDropdown.anchorView = raceTextView
        raceDropdown.dataSource = ["American Indian or Alaska Native",
                                   "Asian",
                                   "Black or African American",
                                   "Native Hawaiian or Other Pacific Islander",
                                   "White",
                                   "Hispanic or Latino",
                                   "Other"]
        raceDropdown.selectionAction = { [weak self] (index, item) in
            self?.raceTextView.text = item
        }
        
//        mentorOrMenteeDropdown.anchorView = mentorOrMenteeTextView
//        mentorOrMenteeDropdown.dataSource = ["Give advice", "Receive advice"]
//        mentorOrMenteeDropdown.selectionAction = { [weak self] (index, item) in
//            self?.mentorOrMenteeTextView.text = item
//        }

    }
    
    var bar: UIView!
    
    func addBar() {
        bar = UIView()
        view.addSubview(bar)
        bar.backgroundColor = UIColor.white
        bar.layer.shadowColor = UIColor.lightGray.cgColor
        bar.layer.shadowOpacity = 1
        bar.layer.shadowOffset = CGSize.zero
        bar.layer.shadowRadius = 5
        bar.anchor(top: scrollView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom:0, paddingRight: 0, width: view.frame.size.width, height: 70)
        bar.addSubview(dismissButton)
        bar.addSubview(saveButton)
        bar.addSubview(createLabel)
        
        dismissButton.anchor(top: bar.topAnchor, left: bar.leftAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        saveButton.anchor(top: bar.topAnchor, left: nil, bottom: nil, right: bar.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        createLabel.centerXAnchor.constraint(equalTo: bar.centerXAnchor).isActive = true
        createLabel.centerYAnchor.constraint(equalTo: bar.centerYAnchor, constant: 10).isActive = true
        
    }
    
    var scrollView: UIScrollView!
    
    func setUpScrollView() {
        scrollView = UIScrollView()
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let height = screensize.height
        self.scrollView.contentSize = CGSize(width:screenWidth, height: height + 550)
        self.scrollView.isScrollEnabled = true
        self.scrollView.frame = self.view.bounds
        view.addSubview(scrollView)
    }
    
    override func viewDidLayoutSubviews() {
        nameTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        companyTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        goalTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        yearTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        genderTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        raceTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        roleTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        emailTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        passwordTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        mentorOrMenteeTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
       
//        bar.layer.shadowOffset =
    }

    
    
    
}
