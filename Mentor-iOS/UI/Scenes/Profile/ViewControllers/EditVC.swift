//
//  OnboardingVC.swift
//  Mentor-iOS
//
//  Created by Melody on 4/6/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit
import Photos
import DropDown

class EditVC: UIViewController, UIImagePickerControllerDelegate {
    
    let picker = UIImagePickerController()
    let keys = AppKeys.instance
    var imageData: Data?
    let viewModel = UserViewModel()
    let genderDropdown = DropDown()
    let roleDropdown = DropDown()
    let raceDropdown = DropDown()
    let yearDropdown = DropDown()


    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        return label
    }()
    
    let nameTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.clear
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Role"
        return label
    }()
    
    let forLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Years of Experience"
        return label
    }()
    
    let yearTextView: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "System", size: 20)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(handleYearDrop), for: .touchUpInside)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    @objc func handleYearDrop() {
        yearDropdown.show()
    }
    
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current Company"
        return label
    }()
    
    let raceDropButton: UIButton = {
        let button = UIButton(type: .system)
//        button.setTitle("select", for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 20)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(handleRaceDrop), for: .touchUpInside)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    

    let roleTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = UIColor.clear
        return textView
        
    }()
    
    let roleDropButton: UIButton = {
        let button = UIButton(type: .custom)
//        button.setTitle("select", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "System", size: 20)
        button.addTarget(self, action: #selector(handleRoleDrop), for: .touchUpInside)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    @objc func handleGenderDrop() {
        genderDropdown.show()
        
    }
    @objc func handleRaceDrop() {
        raceDropdown.show()
        
    }
    
    @objc func handleRoleDrop() {
        roleDropdown.show()
        
    }
    
    let companyTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.clear
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
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
        textView.backgroundColor = UIColor.clear
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    let raceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
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
        textView.backgroundColor = UIColor.clear
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
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
        textView.backgroundColor = UIColor.clear
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    let genderDropButton: UIButton = {
        let button = UIButton(type: .system)
//        button.setTitle("select", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(handleGenderDrop), for: .touchUpInside)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont(name: "System", size: 20)
        return button
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
    
    let editImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("edit", for: .normal)
        button.setTitleColor(UIColor.violetBlue, for: .normal)
        button.addTarget(self, action: #selector(tapImage), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "System", size: 14)
        return button
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
    }
    
    
    @objc func touchDown(sender: UIButton) {
        sender.setTitleColor(UIColor.white, for: UIControlState.normal)
    }
    
    @objc func handleSave() {
        print("save")
//        self.dismiss(animated: false, completion: {
//            AppDelegateViewModel.instance.changeStatus(authStatus: .authorized)
//        })
        updateInfo()
        updateProfileImage()
        ServerNetworking.shared.getInfo(route: .createMatches, params: [:]) {_ in}
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
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
//        addBorders()
        handleDropDowns()
    }
    
    func handleDropDowns() {
        genderDropdown.anchorView = genderDropButton
        genderDropdown.dataSource = ["Man", "Woman", "Other"]
        genderDropdown.selectionAction = { [weak self] (index, item) in
            self?.genderDropButton.setTitle(item, for: .normal)
        }
        
        roleDropdown.anchorView = roleDropButton
        roleDropdown.dataSource = ["Software Engineer", "Product Manager", "Designer", "Other"]
        roleDropdown.selectionAction = { [weak self] (index, item) in
            self?.roleDropButton.setTitle(item, for: .normal)
        }
        
        yearDropdown.anchorView = yearTextView
        yearDropdown.dataSource = ["I am interested in this role", "1", "2", "3",
                                   "4", "5", "6", "7", "8", "9", "10", "11",
                                   "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23",
                                   "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34","35", "36",
                                   "37", "38", "39", "40"]
        yearDropdown.selectionAction = { [weak self] (index, item) in
            if item == "I am interested in this role" {
                self?.yearTextView.setTitle(item, for: .normal)
            } else {
                self?.yearTextView.setTitle(item + " years", for: .normal)
            }
        }
        
        raceDropdown.anchorView = raceDropButton
        raceDropdown.dataSource = ["American Indian or Alaska Native",
                                   "Asian",
                                   "Black or African American",
                                   "Native Hawaiian or Other Pacific Islander",
                                   "White",
                                   "Hispanic or Latino",
                                   "Other"]
        raceDropdown.selectionAction = { [weak self] (index, item) in
            self?.raceDropButton.setTitle(item, for: .normal)
        }
        
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
        let screenHeight = screensize.height
        self.scrollView.contentSize = CGSize(width:screenWidth, height: screenHeight + 350)
        self.scrollView.isScrollEnabled = true
        self.scrollView.frame = self.view.bounds
        view.addSubview(scrollView)
    }
    
    func addBorders() {
        nameTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        companyTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        yearTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        genderDropButton.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        raceDropButton.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        goalTextView.layer.borderColor = UIColor.lightGray.cgColor
        goalTextView.layer.borderWidth = 0.8
        goalTextView.layer.cornerRadius = 5
        roleDropButton.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
    }
    
    override func viewDidLayoutSubviews() {
        nameTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        companyTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        yearTextView.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        genderDropButton.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        raceDropButton.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
        goalTextView.layer.borderColor = UIColor.lightGray.cgColor
        goalTextView.layer.borderWidth = 0.8
        goalTextView.layer.cornerRadius = 5
        roleDropButton.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.8)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
//        addBorders()
    }


}
