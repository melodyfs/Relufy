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
        bgView.backgroundColor = UIColor.clear
        
        view.addSubview(bgView)
        bgView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 260)
    }
    
    func fetchUser() {
        viewModel.fetchUsers(callback: { [unowned self] (users) in
            DispatchQueue.main.async {
                let year = String(describing: users.first!.years)
                self.userInfoItems = users
                UserDefaults.standard.set(users.first?.name, forKey: "name")
                UserDefaults.standard.set(users.first?.image, forKey: "image")
                self.nameLabel.text = users.first?.name
                self.roleLabel.text = (users.first?.role)! + " for \(year) year(s)"
                self.companyInputLabel.text = (users.first?.company)!
                self.goalInputLabel.text = (users.first?.goal)!
                self.raceInputLabel.text = users.first?.race
                self.genderInputLabel.text = users.first?.gender
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setImage()
        navigationController?.navigationBar.isTranslucent = true
        
    }
    
}
