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
        label.text = "Goal"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let goalInputLabel: UILabel = {
        let label = UILabel()
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
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    @objc func handleLogout() {
        print("logout")
        AppDelegateViewModel.instance.changeStatus(authStatus: .unauthorized)
        keychain.clear()
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUpBackground()
        setUpViews()
        fetchUser()
        setImage()
        navigationController?.navigationBar.barTintColor = UIColor.clear.withAlphaComponent(0.1)
    }
    
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
//    weak var editVC = EditVC!.self
    var editVC = EditVC()
    @objc func handleEdit() {
        print("edit")
        
        self.navigationController?.pushViewController(editVC, animated: true)
//        present(editVC, animated: true)
    }
    
    deinit {
        
    }
    
    func setUpViews() {
        let editButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(handleEdit))
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(handleLogout))
        
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(roleLabel)
        view.addSubview(yearLabel)
        view.addSubview(companyInputLabel)
        view.addSubview(goalInputLabel)
        view.addSubview(companyLabel)
        view.addSubview(goalLabel)
        view.addSubview(raceLabel)
        view.addSubview(raceInputLabel)
        view.addSubview(genderLabel)
        view.addSubview(genderInputLabel)
        
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 110).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        roleLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 30).isActive = true
        roleLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor).isActive = true
        
        companyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        companyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 335).isActive = true
        companyInputLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        companyInputLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor, constant: 20).isActive = true
        
        goalLabel.leftAnchor.constraint(equalTo: companyInputLabel.leftAnchor).isActive = true
        goalLabel.topAnchor.constraint(equalTo: companyInputLabel.topAnchor, constant: 40).isActive = true
        goalInputLabel.leftAnchor.constraint(equalTo: goalLabel.leftAnchor).isActive = true
        goalInputLabel.topAnchor.constraint(equalTo: goalLabel.topAnchor, constant: 20).isActive = true
        
        raceLabel.leftAnchor.constraint(equalTo: goalInputLabel.leftAnchor).isActive = true
        raceLabel.topAnchor.constraint(equalTo: goalInputLabel.topAnchor, constant: 40).isActive = true
        raceInputLabel.leftAnchor.constraint(equalTo: raceLabel.leftAnchor).isActive = true
        raceInputLabel.topAnchor.constraint(equalTo: raceLabel.topAnchor, constant: 20).isActive = true
        
        genderLabel.leftAnchor.constraint(equalTo: raceInputLabel.leftAnchor).isActive = true
        genderLabel.topAnchor.constraint(equalTo: raceInputLabel.topAnchor, constant: 40).isActive = true
        genderInputLabel.leftAnchor.constraint(equalTo: genderLabel.leftAnchor).isActive = true
        genderInputLabel.topAnchor.constraint(equalTo: genderLabel.topAnchor, constant: 20).isActive = true
        
    }
}
