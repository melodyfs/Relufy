//
//  ProfileVC.swift
//  Mentor-iOS
//
//  Created by Melody on 3/28/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit
import KeychainSwift

class ProfileVC: UIViewController {
    
    let viewModel = UserViewModel()
    var userInfoItems = [UserItemViewModel]()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        return label
    }()
    
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Role"
        return label
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
        label.text = "Current Company"
        return label
    }()
    
    let companyInputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.text = "Bio"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalInputLabel: UITextView = {
        let label = UITextView()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 1.0)
        return label
    }()
    
    let raceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Race"
        return label
    }()
    
    let raceInputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 1.0)
        return label
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.text = "Gender"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genderInputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 1.0)
        return label
    }()
    
    var bgView: UIImageView!
    
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
    
    @objc func handleLogout() {
        print("logout")
        AppDelegateViewModel.instance.changeStatus(authStatus: .unauthorized)
        keychain.clear()
    }
    
    let keys = AppKeys.instance
  
    override func viewDidLoad() {
        super.viewDidLoad()
        keys.setMentorOrMentee(isMentor: keys.isMentor)
        setUpScrollView()
        setUpBackground()
        view.backgroundColor = UIColor.white
        fetchUser()
        setImage()
       
        setUpViews()
        setUpHeaders()
    }
    
//    weak var editVC = EditVC!.self
//    var editVC = EditVC()
    @objc func handleEdit() {
        print("edit")
        let editVC = EditVC()
        self.navigationController?.pushViewController(editVC, animated: true)
//        present(editVC, animated: true)
    }
    
    deinit {
        print("deinit")
    }
    
    var scrollView: UIScrollView!
    
    func setUpScrollView() {
        scrollView = UIScrollView()
       
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        self.scrollView.contentSize = CGSize(width:screenWidth, height: 800)
        self.scrollView.isScrollEnabled = true
        self.scrollView.frame = CGRect(x: 0, y: 30, width: screenWidth, height: 800)
        view.addSubview(scrollView)
    }
    
    func setUpHeaders() {
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(roleLabel)
        
        profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 80).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        
        roleLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 30).isActive = true
        roleLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor).isActive = true
        
        // V2 design
//        profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40).isActive = true
//        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//
//        nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
//        nameLabel.leftAnchor.constraint(equalTo: profileImageView.leftAnchor, constant: 110).isActive = true
//        
//        roleLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 30).isActive = true
//        roleLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
    }
    
    
    func setUpViews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let editButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEdit))
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleLogout))
        
        scrollView.addSubview(companyInputLabel)
        scrollView.addSubview(goalInputLabel)
        scrollView.addSubview(companyLabel)
        scrollView.addSubview(goalLabel)
        scrollView.addSubview(raceLabel)
        scrollView.addSubview(raceInputLabel)
        scrollView.addSubview(genderLabel)
        scrollView.addSubview(genderInputLabel)
        
        goalLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        goalLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 230).isActive = true
        goalInputLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        goalInputLabel.topAnchor.constraint(equalTo: goalLabel.topAnchor, constant: 20).isActive = true
        goalInputLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        goalInputLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        companyLabel.leftAnchor.constraint(equalTo: goalInputLabel.leftAnchor).isActive = true
        companyLabel.topAnchor.constraint(equalTo: goalInputLabel.topAnchor, constant: 230).isActive = true
        companyInputLabel.leftAnchor.constraint(equalTo: companyLabel.leftAnchor).isActive = true
        companyInputLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor, constant: 20).isActive = true
        
        raceLabel.leftAnchor.constraint(equalTo: companyInputLabel.leftAnchor).isActive = true
        raceLabel.topAnchor.constraint(equalTo: companyInputLabel.topAnchor, constant: 80).isActive = true
        raceInputLabel.leftAnchor.constraint(equalTo: raceLabel.leftAnchor).isActive = true
        raceInputLabel.topAnchor.constraint(equalTo: raceLabel.topAnchor, constant: 20).isActive = true
        
        genderLabel.leftAnchor.constraint(equalTo: raceInputLabel.leftAnchor).isActive = true
        genderLabel.topAnchor.constraint(equalTo: raceInputLabel.topAnchor, constant: 40).isActive = true
        genderInputLabel.leftAnchor.constraint(equalTo: genderLabel.leftAnchor).isActive = true
        genderInputLabel.topAnchor.constraint(equalTo: genderLabel.topAnchor, constant: 20).isActive = true
        
        //V2 design
//        goalLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
//        goalLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 200).isActive = true
//        goalInputLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
//        goalInputLabel.topAnchor.constraint(equalTo: goalLabel.topAnchor, constant: 20).isActive = true
//
//        companyLabel.leftAnchor.constraint(equalTo: goalInputLabel.leftAnchor).isActive = true
//        companyLabel.topAnchor.constraint(equalTo: goalInputLabel.topAnchor, constant: 150).isActive = true
//        companyInputLabel.leftAnchor.constraint(equalTo: companyLabel.leftAnchor).isActive = true
//        companyInputLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor, constant: 20).isActive = true
//
//        raceLabel.leftAnchor.constraint(equalTo: companyInputLabel.leftAnchor).isActive = true
//        raceLabel.topAnchor.constraint(equalTo: companyInputLabel.topAnchor, constant: 80).isActive = true
//        raceInputLabel.leftAnchor.constraint(equalTo: raceLabel.leftAnchor).isActive = true
//        raceInputLabel.topAnchor.constraint(equalTo: raceLabel.topAnchor, constant: 20).isActive = true
//
//        genderLabel.leftAnchor.constraint(equalTo: raceInputLabel.leftAnchor).isActive = true
//        genderLabel.topAnchor.constraint(equalTo: raceInputLabel.topAnchor, constant: 40).isActive = true
//        genderInputLabel.leftAnchor.constraint(equalTo: genderLabel.leftAnchor).isActive = true
//        genderInputLabel.topAnchor.constraint(equalTo: genderLabel.topAnchor, constant: 20).isActive = true
        
    }
}
