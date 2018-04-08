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

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        return label
    }()
    
    let nameTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Name textview"
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
        textView.layer.borderColor = UIColor.violetBlue.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Role"
        return label
    }()
    
    let forLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "For"
        return label
    }()
    
    let yearTextView: UITextView = {
        let textView = UITextView()
        textView.text = "3"
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
        textView.layer.borderColor = UIColor.violetBlue.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
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
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Company"
        return label
    }()
    
    
    let softwareEngineerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Software Engineer", for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 16)
        //        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.violetBlue, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red:0.37, green:0.44, blue:0.93, alpha:1.0).cgColor
        //        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
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
    
    let productManagerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Product Manager", for: .normal)
        button.setTitleColor(UIColor.violetBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 16)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.violetBlue.cgColor
        //        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
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
        //        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        return button
    }()
    
    let companyTextView: UITextView = {
        let textView = UITextView()
        textView.text = "company textview"
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
        textView.layer.borderColor = UIColor.violetBlue.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.text = "Goal"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Goal textview"
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
        textView.layer.borderColor = UIColor.violetBlue.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "Profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.orange
        return imageView
    }()
    
    @objc func tapImage(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("image tapped")
        openPhotoLibrary()
//        PhotoHelper().presentActionSheet(from: EditVC())
        
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
    
    var prevVC: ProfileVC!
    
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
        if keys.isMentor {
            UploadImage.upload(route: .updateMentor,  imageData: imageData!)
        } else {
            UploadImage.upload(route: .updateMentee, imageData: imageData!)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUpViews()
//        AppDelegateViewModel.instance.changeStatus(authStatus: .editProfile)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isBeingDismissed {
            let profileVC = ProfileVC()
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    func setUpViews() {
        
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(nameTextView)
        view.addSubview(roleLabel)
        view.addSubview(softwareEngineerButton)
        view.addSubview(productManagerButton)
        view.addSubview(designerButton)
        view.addSubview(forLabel)
        view.addSubview(yearTextView)
        view.addSubview(yearLabel)
        view.addSubview(companyLabel)
        view.addSubview(companyTextView)
        view.addSubview(goalLabel)
        view.addSubview(goalTextView)
        view.addSubview(dismissButton)
        view.addSubview(saveButton)
        
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        
        nameTextView.anchor(top: nameLabel.topAnchor, left: nameLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 70, height: 40)
        
        roleLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        roleLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 80).isActive = true
        
        softwareEngineerButton.anchor(top: roleLabel.topAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: softwareEngineerButton.intrinsicContentSize.width + 5, height: softwareEngineerButton.intrinsicContentSize.height + 5)
        
        productManagerButton.anchor(top: roleLabel.topAnchor, left: softwareEngineerButton.leftAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 150, paddingBottom: 0, paddingRight: 0, width: productManagerButton.intrinsicContentSize.width + 5, height: productManagerButton.intrinsicContentSize.height + 5)
        
        designerButton.anchor(top: roleLabel.topAnchor, left: softwareEngineerButton.leftAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 291, paddingBottom: 0, paddingRight: 0, width: designerButton.intrinsicContentSize.width + 5, height: designerButton.intrinsicContentSize.height + 5)
        
        forLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        forLabel.topAnchor.constraint(equalTo: roleLabel.topAnchor, constant: 75).isActive = true
        
        yearTextView.anchor(top: forLabel.topAnchor, left: forLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 200, width: 40, height: 40)
        
        yearLabel.leftAnchor.constraint(equalTo: yearTextView.leftAnchor, constant: 200).isActive = true
        yearLabel.topAnchor.constraint(equalTo: yearTextView.topAnchor, constant: 7).isActive = true
        
        companyLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        companyLabel.topAnchor.constraint(equalTo: forLabel.topAnchor, constant: 75).isActive = true
        
        companyTextView.anchor(top: companyLabel.topAnchor, left: forLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 100, width: 40, height: 40)
        
        goalLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        goalLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor, constant: 75).isActive = true
        
        goalTextView.anchor(top: goalLabel.topAnchor, left: goalLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 50, width: 40, height: 100)
        
        dismissButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        saveButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
    }

    


}
