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
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        return label
    }()
    
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
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
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current company: "
        return label
    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.text = "Goal: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "Profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.orange
        return imageView
    }()
    
    
    let connectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        return button
    }()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUpViews()
        fetchUser()
        setImage()
    }
    
    func fetchUser() {
        viewModel.fetchUsers(callback: { [unowned self] (users) in
            DispatchQueue.main.async {
                let year = String(describing: users.first!.years)
                self.userInfoItems = users
                self.nameLabel.text = users.first?.name
                self.roleLabel.text = (users.first?.role)! + " for \(year) year(s)"
                self.companyLabel.text = "Current Company: " + (users.first?.company)!
                self.goalLabel.text = "Goal: " + (users.first?.goal)!
//                self.profileImageView.getImageFromURL(url: (users.first?.image)!)
            }
        })
        
    }
    
    func setImage() {
        if AppKeys.instance.isMentor {
            ServerNetworking.shared.getInfo(route: .getMentorImage, params: [:]) { info in
                let userinfo = try? JSONDecoder().decode([User].self, from: info)
                self.profileImageView.getImageFromURL(url: (userinfo?.first?.image_file)!)
                KeychainSwift().set((userinfo?.first?.image_file)!, forKey: "image")
            }
        } else {
            ServerNetworking.shared.getInfo(route: .getMenteeImage, params: [:]) { info in
                let userinfo = try? JSONDecoder().decode([User].self, from: info)
                self.profileImageView.getImageFromURL(url: (userinfo?.first?.image_file)!)
                KeychainSwift().set((userinfo?.first?.image_file)!, forKey: "image")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setImage()
    }
    
    @objc func handleEdit() {
        print("edit")
        let editVC = EditVC()
        self.present(editVC, animated: true)
    }
    
    func setUpViews() {
        
        let editButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEdit))
        navigationItem.rightBarButtonItem = editButtonItem
        
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(roleLabel)
        view.addSubview(yearLabel)
        view.addSubview(companyLabel)
        view.addSubview(goalLabel)
        
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 110).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        roleLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 30).isActive = true
        roleLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor).isActive = true
        
        companyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        companyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 375).isActive = true
        
        goalLabel.leftAnchor.constraint(equalTo: companyLabel.leftAnchor).isActive = true
        goalLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor, constant: 55).isActive = true
        
        
    }
}
