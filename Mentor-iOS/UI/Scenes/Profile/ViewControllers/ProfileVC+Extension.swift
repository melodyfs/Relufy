//
//  ProfileVC+Extension.swift
//  Mentor-iOS
//
//  Created by Melody on 4/13/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

extension ProfileVC {
    
    func setUpBackground() {
        let bgView = UIImageView()
        bgView.getImageFromURL(url: UserDefaults.standard.string(forKey: "image")!)
        bgView.addBlurEffect()
        bgView.backgroundColor = UIColor.violetBlue.withAlphaComponent(0.5)
        
        scrollView.addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        bgView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        bgView.heightAnchor.constraint(equalToConstant: 230).isActive = true
       
//        bgView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 260)
    }
    
    func fetchUser() {
        viewModel.fetchUsers(callback: { [unowned self] (users) in
            DispatchQueue.main.async {
                let year = String(describing: users.first!.years)
                self.userInfoItems = users
                UserDefaults.standard.set(users.first?.name, forKey: "name")
                UserDefaults.standard.set(users.first?.image, forKey: "image")
                self.nameLabel.text = users.first?.name
                self.companyInputLabel.text = (users.first?.company)!
                self.goalInputLabel.text = (users.first?.goal)!
                self.raceInputLabel.text = users.first?.race
                self.genderInputLabel.text = users.first?.gender
                
                if users.first!.years == 0 {
                    self.roleLabel.text = "Interested In Becoming \((users.first?.role)!)"
                } else {
                    self.roleLabel.text = (users.first?.role)! + " for \(year) years"
                }
            }
        })
        
    }
    
    func setImage() {
        if AppKeys.instance.isMentor {
            ServerNetworking.shared.getInfo(route: .getMentorImage, params: [:]) { [unowned self] info in
                if let userinfo = try? JSONDecoder().decode([User].self, from: info) {
                    DispatchQueue.main.async {
                        self.profileImageView.getImageFromURL(url: (userinfo.first?.image_file)!)
                    }
                    UserDefaults.standard.set((userinfo.first?.image_file)!, forKey: "image")
                }
            }
        } else {
            ServerNetworking.shared.getInfo(route: .getMenteeImage, params: [:]) { [unowned self] info in
                if let userinfo = try? JSONDecoder().decode([User].self, from: info){
                    DispatchQueue.main.async {
                        self.profileImageView.getImageFromURL(url: (userinfo.first?.image_file)!)
                    }
                    UserDefaults.standard.set((userinfo.first?.image_file)!, forKey: "image")
                }
            }
        }
        
    }
    
   
    
}
