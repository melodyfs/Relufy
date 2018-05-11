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
    static var instance = EditVC()

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
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.isUserInteractionEnabled = true
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
        imageView.image = UIImage(named: "profileImageHolder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    @objc func tapImage(tapGestureRecognizer: UITapGestureRecognizer) {
        openPhotoLibrary()
    }
    
    let saveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor.violetBlue, for: .normal)
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        return button
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "dismiss"), for: .normal) 
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        return button
    }()
    
    @objc func handleDismiss() {
        print("dismiss")

        self.navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: {
//            AppDelegateViewModel.instance.changeStatus(authStatus: .authorized)
//        })
    }
    
    deinit {
//        print("christy says hi:)")
    }
    
    @objc func touchDown(sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: UIControlState.normal)
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
        keys.setMentorOrMentee(isMentor: keys.isMentor)
        setUpScrollView()
        view.backgroundColor = UIColor.white
        setUpViews()
        fetchUser()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImage))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        addBorders()
    }
    
    var bar: UIView!
    
    func addBar() {
        bar = UIView()
        view.addSubview(bar)
        bar.backgroundColor = UIColor.white
        bar.anchor(top: scrollView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom:0, paddingRight: 0, width: view.frame.size.width, height: 70)
        bar.addSubview(dismissButton)
        bar.addSubview(saveButton)
        
        dismissButton.anchor(top: bar.topAnchor, left: bar.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        saveButton.anchor(top: bar.topAnchor, left: nil, bottom: nil, right: bar.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
       
    }
    
    var scrollView: UIScrollView!
    
    func setUpScrollView() {
        scrollView = UIScrollView()
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        self.scrollView.contentSize = CGSize(width:screenWidth, height: 1000)
        self.scrollView.isScrollEnabled = true
        self.scrollView.frame = self.view.bounds
        view.addSubview(scrollView)
    }
    
    func addBorders() {
        nameTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        companyTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        goalTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        yearTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        genderTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        raceTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
    }
    
    override func viewDidLayoutSubviews() {
        nameTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        companyTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        goalTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        yearTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        genderTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        raceTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
//        bar.layer.addBorder(edge: .bottom, color: UIColor.gray, thickness: 0.8)
    }


}
