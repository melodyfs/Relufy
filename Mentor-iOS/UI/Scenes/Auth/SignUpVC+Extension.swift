//
//  SignUpVC+Extension.swift
//  Mentor-iOS
//
//  Created by Melody on 5/1/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation
import UIKit

extension SignUpVC {
    
    func collectedParams() -> [String: String]{
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
    
    
//    func updateProfileImage() {
//        if imageData != nil {
//            if keys.isMentor {
//                UploadImage.upload(route: .updateMentor,  imageData: imageData!)
//            } else {
//                UploadImage.upload(route: .updateMentee, imageData: imageData!)
//            }
//        }
//    }
    
   
    
    func setUpViews() {
//        scrollView.addSubview(dismissButton)
//        scrollView.addSubview(saveButton)
//        scrollView.addSubview(profileImageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(nameTextView)
        scrollView.addSubview(roleLabel)
//        scrollView.addSubview(roleTextView)
        scrollView.addSubview(roleDropButton)
//        scrollView.addSubview(mentorOrMenteeTextView)
//        scrollView.addSubview(mentorOrMenteeLabel)
//        scrollView.addSubview(mentorMenteeDropButton)
        scrollView.addSubview(forLabel)
        scrollView.addSubview(yearTextView)
//        scrollView.addSubview(yearLabel)
        scrollView.addSubview(companyLabel)
        scrollView.addSubview(companyTextView)
        scrollView.addSubview(goalLabel)
        scrollView.addSubview(goalTextView)
        scrollView.addSubview(raceLabel)
//        scrollView.addSubview(raceTextView)
        scrollView.addSubview(genderLabel)
//        scrollView.addSubview(genderTextView)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(emailTextView)
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(passwordTextView)
        scrollView.addSubview(genderDropButton)
        scrollView.addSubview(raceDropButton)
        scrollView.addSubview(saveButton)
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = screenWidth - 40
        
//        profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 60).isActive = true
//        profileImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
//        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 90).isActive = true
        
        nameTextView.anchor(top: nameLabel.topAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: 40)
        
        roleLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        roleLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 100).isActive = true
        
//        roleTextView.anchor(top: roleLabel.topAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: 40)
        
//        roleDropButton.anchor(top: roleLabel.topAnchor, left: roleTextView.leftAnchor, bottom: nil, right: nil, paddingTop: 35, paddingLeft: 200, paddingBottom: 0, paddingRight: 0, width: 50, height: 20)
        roleDropButton.anchor(top: roleLabel.topAnchor, left: roleLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: 40)
        
        forLabel.leftAnchor.constraint(equalTo: roleDropButton.leftAnchor).isActive = true
        forLabel.topAnchor.constraint(equalTo: roleDropButton.topAnchor, constant: 80).isActive = true
        
        yearTextView.anchor(top: forLabel.topAnchor, left: forLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: 40)
        
//        yearLabel.leftAnchor.constraint(equalTo: yearTextView.leftAnchor, constant: 200).isActive = true
//        yearLabel.topAnchor.constraint(equalTo: yearTextView.topAnchor, constant: 7).isActive = true
        
        companyLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        companyLabel.topAnchor.constraint(equalTo: forLabel.topAnchor, constant: 100).isActive = true
        
        companyTextView.anchor(top: companyLabel.topAnchor, left: forLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: 40)
        
        goalLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        goalLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor, constant: 100).isActive = true
        
        goalTextView.anchor(top: goalLabel.topAnchor, left: goalLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: 40)
        
        raceLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        raceLabel.topAnchor.constraint(equalTo: goalLabel.topAnchor, constant: 100).isActive = true
        
//        raceTextView.anchor(top: raceLabel.topAnchor, left: raceLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 50, width: 320, height: 40)
        
//        raceDropButton.anchor(top: raceTextView.topAnchor, left: raceTextView.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 310, paddingBottom: 0, paddingRight: 0, width: 50, height: 10)
        raceDropButton.anchor(top: raceLabel.topAnchor, left: raceLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: 40)
        
        genderLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        genderLabel.topAnchor.constraint(equalTo: raceLabel.topAnchor, constant: 100).isActive = true
        
//        genderTextView.anchor(top: genderLabel.topAnchor, left: genderLabel.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 250, width: 70, height: 40)
        
//        genderDropButton.anchor(top: genderTextView.topAnchor, left: genderTextView.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 140, paddingBottom: 0, paddingRight: 0, width: 50, height: 10)
        genderDropButton.anchor(top: genderLabel.topAnchor, left: genderLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: 40)
        
        emailLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        emailLabel.topAnchor.constraint(equalTo: genderLabel.topAnchor, constant: 100).isActive = true
        
        emailTextView.anchor(top: emailLabel.topAnchor, left: emailLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: 40)
        
        passwordLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: emailLabel.topAnchor, constant: 100).isActive = true
        
        passwordTextView.anchor(top: passwordLabel.topAnchor, left: passwordLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: itemWidth, height: 40)
        
        saveButton.anchor(top: passwordTextView.topAnchor, left: passwordLabel.leftAnchor, bottom: scrollView.bottomAnchor, right: nil, paddingTop: 70, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: itemWidth, height: 50)
//        saveButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
//        saveButton.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
//        saveButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
//        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func authorize() {
        appDelegate.changeStatus(authStatus: .authorized)
    }
    
    func unauthorize() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setKeychainCredential() {
        keychain.set(emailTextView.text!, forKey: "email")
        keychain.set(passwordTextView.text!, forKey: "password")
    }
    
    
}
