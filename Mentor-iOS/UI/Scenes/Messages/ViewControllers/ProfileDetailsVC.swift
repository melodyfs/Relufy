//
//  ProfileDetailsVC.swift
//  Mentor-iOS
//
//  Created by Melody on 5/10/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation

import UIKit

class ProfileDetailsVC: UIViewController {
    
    var selectedUser = [MessageItemViewModel]()
    var userImage: UIImage!
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
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
        label.isUserInteractionEnabled = false
        return label
    }()
    
    
    let companyInputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    let raceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.text = "Race"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let raceInputLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
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
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "Profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    func setUpHeaders() {
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(roleLabel)
        
        profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 70).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 50).isActive = true
        
        roleLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 30).isActive = true
        roleLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor).isActive = true
        
        //        profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 60).isActive = true
        //        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        //        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //        profileImageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30).isActive = true
        //
        //        nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 20).isActive = true
        //        nameLabel.leftAnchor.constraint(equalTo: profileImageView.leftAnchor,  constant: 120).isActive = true
        //
        //        roleLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 30).isActive = true
        //        roleLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        
        //        connectButton.translatesAutoresizingMaskIntoConstraints = false
        //        connectButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true
        
    }

    
    func setUpViews() {
        view.backgroundColor = UIColor.white
        scrollView.addSubview(companyInputLabel)
        scrollView.addSubview(goalLabel)
        scrollView.addSubview(companyLabel)
        scrollView.addSubview(goalInputLabel)
        scrollView.addSubview(raceLabel)
        scrollView.addSubview(raceInputLabel)
        scrollView.addSubview(genderLabel)
        scrollView.addSubview(genderInputLabel)
        
        
        goalLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30).isActive = true
        goalLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 240).isActive = true
        goalInputLabel.leftAnchor.constraint(equalTo: goalLabel.leftAnchor).isActive = true
        goalInputLabel.topAnchor.constraint(equalTo: goalLabel.topAnchor, constant: 20).isActive = true
        goalInputLabel.widthAnchor.constraint(equalToConstant: screensize.width - 50).isActive = true
        goalInputLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        companyLabel.anchor(top: goalInputLabel.topAnchor, left: goalInputLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 160, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        companyInputLabel.leftAnchor.constraint(equalTo: companyLabel.leftAnchor).isActive = true
        companyInputLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor, constant: 20).isActive = true
        
        
        raceLabel.leftAnchor.constraint(equalTo: companyInputLabel.leftAnchor).isActive = true
        raceLabel.topAnchor.constraint(equalTo: companyInputLabel.topAnchor, constant: 70).isActive = true
        raceInputLabel.leftAnchor.constraint(equalTo: raceLabel.leftAnchor).isActive = true
        raceInputLabel.topAnchor.constraint(equalTo: raceLabel.topAnchor, constant: 20).isActive = true
        
        genderLabel.leftAnchor.constraint(equalTo: raceInputLabel.leftAnchor).isActive = true
        genderLabel.topAnchor.constraint(equalTo: raceInputLabel.topAnchor, constant: 70).isActive = true
        genderInputLabel.leftAnchor.constraint(equalTo: genderLabel.leftAnchor).isActive = true
        genderInputLabel.topAnchor.constraint(equalTo: genderLabel.topAnchor, constant: 20).isActive = true
        
    }
    
    var scrollView: UIScrollView!
    let screensize: CGRect = UIScreen.main.bounds
    
    func setUpScrollView() {
        scrollView = UIScrollView()
        let screenWidth = screensize.width
        let height = screensize.height
        self.scrollView.contentSize = CGSize(width:screenWidth, height: height + 550)
        self.scrollView.isScrollEnabled = true
        self.scrollView.frame = self.view.bounds
        view.addSubview(scrollView)
    }
    
    func setValues() {
        
        if (selectedUser.first?.image)! == "/image_files/original/missing.png" {
            profileImageView.image = UIImage(named: "profileImageHolder")
            
        } else {
            profileImageView.getImageFromURL(url: (selectedUser.first?.image)!)
            
        }
        
        userImage = profileImageView.image
        nameLabel.text = (selectedUser.first!.name)
        roleLabel.text = selectedUser.first!.role + " for \((selectedUser.first!.years)) years"
        goalInputLabel.text = selectedUser.first?.goal
        companyInputLabel.text = selectedUser.first?.company
        raceInputLabel.text = selectedUser.first?.race
        genderInputLabel.text = selectedUser.first?.gender
    }
    
    func setUpBackground() {
        let bgView = UIImageView()
        //        bgView.getImageFromURL(url: UserDefaults.standard.string(forKey: "image")!)
        //        bgView.image = userImage
        //        bgView.addBlurEffect()
        bgView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        scrollView.addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        bgView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        bgView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        bgView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScrollView()
        setValues()
        setUpBackground()
        setUpHeaders()
        setUpViews()
    }
}
