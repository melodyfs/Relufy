//
//  OnboardingVC.swift
//  Mentor-iOS
//
//  Created by Melody on 4/6/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit
import Photos

class EditVC: UIViewController, UIImagePickerControllerDelegate {
    
    let picker = UIImagePickerController()
    let keys = AppKeys.instance
    var imageData: Data?
    let viewModel = UserViewModel()

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
//        textView.text = "Name textview"
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
//        textView.layer.borderColor = UIColor.violetBlue.cgColor
//        textView.layer.borderWidth = 1
//        textView.layer.cornerRadius = 5
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
//        textView.text = "3"
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
//        textView.layer.borderColor = UIColor.violetBlue.cgColor
//        textView.layer.borderWidth = 1
//        textView.layer.cornerRadius = 5
        return textView
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "year(s)"
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
    
    
    let softwareEngineerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Software Engineer", for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 16)
        button.setTitleColor(UIColor.violetBlue, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red:0.37, green:0.44, blue:0.93, alpha:1.0).cgColor
        button.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        return button
        
    }()
    
    let productManagerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Product Manager", for: .normal)
        button.setTitleColor(UIColor.violetBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 16)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.violetBlue.cgColor
        button.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        return button
    }()
    
    let designerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Designer", for: .normal)
        button.setTitleColor(UIColor.violetBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 16)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.violetBlue.cgColor
        button.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonSelected(sender: UIButton) {
        let buttons = [softwareEngineerButton, productManagerButton, designerButton]
        buttons.forEach {
            $0.isSelected = false
            $0.backgroundColor = UIColor.white
            $0.setTitleColor(UIColor.violetBlue, for: .normal)
        }
        
        sender.isSelected = true
        if sender.isSelected {
            sender.backgroundColor = UIColor.violetBlue
            sender.setTitleColor(UIColor.white, for: .selected)
        }
        
    }
    
    let companyTextView: UITextView = {
        let textView = UITextView()
//        textView.text = "company textview"
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
//        textView.layer.borderColor = UIColor.violetBlue.cgColor
//        textView.layer.borderWidth = 1
//        textView.layer.cornerRadius = 5
        return textView
    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.text = "What's your goal for giving/receiving mentorship?"
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
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
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
//        textView.text = "gender textview"
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "Profile")
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
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDismiss() {
        print("dismiss")

        self.dismiss(animated: false, completion: {
            AppDelegateViewModel.instance.changeStatus(authStatus: .authorized)
        })
    }
    
    @objc func handleSave() {
        print("save")
        self.dismiss(animated: false, completion: {
            AppDelegateViewModel.instance.changeStatus(authStatus: .authorized)
        })
        updateInfo()
        updateProfileImage()
        ServerNetworking.shared.getInfo(route: .createMatches, params: [:]) {_ in}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUpViews()
        fetchUser()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        nameTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.6)
        companyTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.6)
        goalTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.6)
        yearTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.6)
        genderTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.6)
        raceTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.6)
    }


}
