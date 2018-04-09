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
        let buttons = [softwareEngineerButton, productManagerButton, designerButton]
        for button in buttons {
            if button.isSelected {
                role = (button.titleLabel?.text)!
            }
        }
        
        let params = ["name": nameTextView.text ?? "None",
                      "years_experience": yearTextView.text ?? "0",
                      "company": companyTextView.text ?? "None",
                      "goal": goalTextView.text ?? "None",
                      "role": role,
                      "race": raceTextView.text ?? "None",
                      "gender": genderTextView.text ?? "None"]
        return params
    }
    
    
    
    func fetchUser() {
        viewModel.fetchUsers(callback: { [unowned self] (users) in
            DispatchQueue.main.async {
                let year = String(describing: users.first!.years)
                self.nameTextView.text = users.first?.name
                //                self.ro.text = (users.first?.role)! + " for \(year) year(s)"
                self.yearTextView.text = String(describing: users.first!.years)
                self.companyTextView.text = users.first?.company
                self.goalTextView.text = users.first?.goal
                self.raceTextView.text = users.first?.race
                self.genderTextView.text = users.first?.gender
                self.profileImageView.getImageFromURL(url: (UserDefaults.standard.string(forKey: "image"))!)
                
                let buttons = [self.softwareEngineerButton, self.productManagerButton, self.designerButton]
                for button in buttons {
                    if button.titleLabel?.text == users.first?.role {
                        self.buttonSelected(sender: button)
                    }
                }
            }
        })
        
    }

    
    func updateInfo() {
        let params = collectParams()
        if keys.isMentor {
            ServerNetworking.shared.getInfo(route: .updateMentor, params: params) {_ in}
        } else {
            ServerNetworking.shared.getInfo(route: .updateMentee, params: params) {_ in}
        }
    }
    
    func updateProfileImage() {
        if imageData != nil {
            if keys.isMentor {
                UploadImage.upload(route: .updateMentor,  imageData: imageData!)
            } else {
                UploadImage.upload(route: .updateMentee, imageData: imageData!)
            }
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
        view.addSubview(raceLabel)
        view.addSubview(raceTextView)
        view.addSubview(genderLabel)
        view.addSubview(genderTextView)
        
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        
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
        
        goalTextView.anchor(top: goalLabel.topAnchor, left: goalLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 50, width: 40, height: 40)
        
        raceLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        raceLabel.topAnchor.constraint(equalTo: goalLabel.topAnchor, constant: 75).isActive = true
        
        raceTextView.anchor(top: raceLabel.topAnchor, left: raceLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 50, width: 40, height: 40)
        
        genderLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        genderLabel.topAnchor.constraint(equalTo: raceLabel.topAnchor, constant: 75).isActive = true
        
        genderTextView.anchor(top: genderLabel.topAnchor, left: genderLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 50, width: 40, height: 40)
        
        dismissButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        saveButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
    }

    
}
