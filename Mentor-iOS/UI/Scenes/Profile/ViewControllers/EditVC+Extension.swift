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
        var role = ""
//        let buttons = [softwareEngineerButton, productManagerButton, designerButton]
//        for button in buttons {
//            if button.isSelected {
//                role = (button.titleLabel?.text)!
//            }
//        }
        
        let params = ["name": nameTextView.text ?? "None",
                      "years_experience": yearTextView.text ?? "0",
                      "company": companyTextView.text ?? "None",
                      "goal": goalTextView.text ?? "None",
                      "role": roleTextView.text ?? "None",
                      "race": raceTextView.text ?? "None",
                      "gender": genderTextView.text ?? "None"]
        return params
    }
    
    
    
    func fetchUser() {
        viewModel.fetchUsers(callback: { [unowned self] (users) in
            DispatchQueue.main.async {
//                let year = String(describing: users.first!.years)
                self.nameTextView.text = users.first?.name
                //                self.ro.text = (users.first?.role)! + " for \(year) year(s)"
                self.yearTextView.text = String(describing: users.first!.years)
                self.companyTextView.text = users.first?.company
                self.goalTextView.text = users.first?.goal
                self.raceTextView.text = users.first?.race
                self.genderTextView.text = users.first?.gender
                self.profileImageView.getImageFromURL(url: (UserDefaults.standard.string(forKey: "image"))!)
                self.roleTextView.text = users.first?.role
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
        scrollView.addSubview(roleTextView)
        scrollView.addSubview(roleDropButton)
        scrollView.addSubview(genderDropButton)
        scrollView.addSubview(forLabel)
        scrollView.addSubview(yearTextView)
        scrollView.addSubview(yearLabel)
        scrollView.addSubview(companyLabel)
        scrollView.addSubview(companyTextView)
        scrollView.addSubview(goalLabel)
        scrollView.addSubview(goalTextView)
        scrollView.addSubview(raceLabel)
        scrollView.addSubview(raceTextView)
        scrollView.addSubview(raceDropButton)
        scrollView.addSubview(genderLabel)
        scrollView.addSubview(genderTextView)
        
        profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 60).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 170).isActive = true
        
        nameTextView.anchor(top: nameLabel.topAnchor, left: nameLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 70, height: 40)
        
        roleLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        roleLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 100).isActive = true
        
        roleTextView.anchor(top: roleLabel.topAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 40)
        
        roleDropButton.anchor(top: roleTextView.topAnchor, left: roleTextView.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 230, paddingBottom: 0, paddingRight: 0, width: 50, height: 20)
        
        
        forLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        forLabel.topAnchor.constraint(equalTo: roleLabel.topAnchor, constant: 130).isActive = true
        
        yearTextView.anchor(top: forLabel.topAnchor, left: forLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 200, width: 40, height: 40)
        
        yearLabel.leftAnchor.constraint(equalTo: yearTextView.leftAnchor, constant: 200).isActive = true
        yearLabel.topAnchor.constraint(equalTo: yearTextView.topAnchor, constant: 7).isActive = true
        
        companyLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        companyLabel.topAnchor.constraint(equalTo: forLabel.topAnchor, constant: 100).isActive = true
        
        companyTextView.anchor(top: companyLabel.topAnchor, left: forLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 100, width: 40, height: 40)
        
        
        raceLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        raceLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor, constant: 100).isActive = true
        
        raceTextView.anchor(top: raceLabel.topAnchor, left: raceLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 320, height: 40)
        raceDropButton.anchor(top: raceTextView.topAnchor, left: raceTextView.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 330, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
        genderLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        genderLabel.topAnchor.constraint(equalTo: raceLabel.topAnchor, constant: 100).isActive = true
        
        genderTextView.anchor(top: genderLabel.topAnchor, left: genderLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 40)
        genderDropButton.anchor(top: genderTextView.topAnchor, left: genderTextView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 120, paddingBottom: 0, paddingRight: 0, width: 45, height: 40)
        
        
        goalLabel.leftAnchor.constraint(equalTo: genderLabel.leftAnchor).isActive = true
        goalLabel.topAnchor.constraint(equalTo: genderLabel.topAnchor, constant: 100).isActive = true
        
        goalTextView.anchor(top: goalLabel.topAnchor, left: goalLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 30, width: 300, height: 200)
        
    }

    
}
