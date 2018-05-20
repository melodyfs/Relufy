//
//  EditVC+Extension.swift
//  Mentor-iOS
//
//  Created by Melody on 4/8/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

extension EditVC {
    
    func collectParams() -> [String: String]{
        var year = ""
        
        if yearTextView.titleLabel?.text == "I am interested in this role" {
            year = "0"
        } else {
            let cleanedYear = yearTextView.titleLabel?.text!.components(separatedBy: " ").dropLast().joined(separator: " ")
            year = cleanedYear!
        }
        
        let params = ["name": nameTextView.text ?? "None",
                      "years_experience": year ?? "0",
                      "company": companyTextView.text ?? "None",
                      "goal": goalTextView.text ?? "None",
                      "role": roleDropButton.titleLabel!.text ?? "None",
                      "race": raceDropButton.titleLabel!.text ?? "None",
                      "gender": genderDropButton.titleLabel!.text ?? "None"]
        return params
    }
    
    
    
    func fetchUser() {
        viewModel.fetchUsers(callback: { [unowned self] (users) in
            DispatchQueue.main.async {
//                let year = String(describing: users.first!.years)
                self.nameTextView.text = users.first?.name
                self.companyTextView.text = users.first?.company
                self.goalTextView.text = users.first?.goal
                self.raceDropButton.setTitle(users.first?.race, for: .normal)
                self.genderDropButton.setTitle(users.first?.gender, for: .normal)
                self.profileImageView.getImageFromURL(url: (UserDefaults.standard.string(forKey: "image"))!)
                self.roleDropButton.setTitle(users.first?.role, for: .normal)
                
                if users.first!.years == 0 {
                    self.yearTextView.setTitle("I am interested in this role", for: .normal)
                } else {
                    self.yearTextView.setTitle(String(users.first!.years) + " years", for: .normal)
                }
            }
        })
        
    }

    
    func updateInfo() {
        let params = collectParams()
        ServerNetworking.shared.getInfo(route: .updateMentor, params: params) {_ in}
        ServerNetworking.shared.getInfo(route: .updateMentee, params: params) {_ in}
    }
    
    func updateProfileImage() {
        if imageData != nil {
            UploadImage.upload(route: .updateMentor,  imageData: imageData!)
            UploadImage.upload(route: .updateMentee, imageData: imageData!)
        }
    }
    
    func setUpViews() {
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(nameTextView)
        scrollView.addSubview(roleLabel)
//        scrollView.addSubview(roleTextView)
        scrollView.addSubview(roleDropButton)
        scrollView.addSubview(genderDropButton)
        scrollView.addSubview(forLabel)
        scrollView.addSubview(yearTextView)
//        scrollView.addSubview(yearLabel)
        scrollView.addSubview(companyLabel)
        scrollView.addSubview(companyTextView)
        scrollView.addSubview(goalLabel)
        scrollView.addSubview(goalTextView)
        scrollView.addSubview(raceLabel)
//        scrollView.addSubview(raceTextView)
        scrollView.addSubview(raceDropButton)
        scrollView.addSubview(genderLabel)
//        scrollView.addSubview(genderTextView)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 60).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 170).isActive = true
        
        nameTextView.anchor(top: nameLabel.topAnchor, left: nameLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: -5, paddingBottom: 0, paddingRight: 30, width: 70, height: 40)
        
        roleLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        roleLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 100).isActive = true
        
        roleDropButton.anchor(top: roleLabel.topAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: screenWidth - 50, height: 40)
    
        
        
        forLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        forLabel.topAnchor.constraint(equalTo: roleLabel.topAnchor, constant: 100).isActive = true
        
        yearTextView.anchor(top: forLabel.topAnchor, left: forLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: screenWidth - 50, height: 40)
        
//        yearLabel.leftAnchor.constraint(equalTo: yearTextView.leftAnchor, constant: screenWidth - 100).isActive = true
//        yearLabel.topAnchor.constraint(equalTo: yearTextView.topAnchor, constant: 7).isActive = true
        
        companyLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        companyLabel.topAnchor.constraint(equalTo: forLabel.topAnchor, constant: 100).isActive = true
        
        companyTextView.anchor(top: companyLabel.topAnchor, left: forLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: -5, paddingBottom: 0, paddingRight: 0, width: screenWidth - 50, height: 40)
        
        
        raceLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        raceLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor, constant: 100).isActive = true
        
        raceDropButton.anchor(top: raceLabel.topAnchor, left: raceLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: screenWidth - 50, height: 40)
//        raceDropButton.anchor(top: raceTextView.topAnchor, left: raceTextView.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 280, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
        genderLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        genderLabel.topAnchor.constraint(equalTo: raceLabel.topAnchor, constant: 100).isActive = true
        
        genderDropButton.anchor(top: genderLabel.topAnchor, left: genderLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: screenWidth - 50, height: 40)
//        genderDropButton.anchor(top: genderTextView.topAnchor, left: genderTextView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 120, paddingBottom: 0, paddingRight: 0, width: 45, height: 40)
        
        
        goalLabel.leftAnchor.constraint(equalTo: genderLabel.leftAnchor).isActive = true
        goalLabel.topAnchor.constraint(equalTo: genderLabel.topAnchor, constant: 100).isActive = true
        
        goalTextView.anchor(top: goalLabel.topAnchor, left: goalLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 300, height: 200)
        
    }

    
}
