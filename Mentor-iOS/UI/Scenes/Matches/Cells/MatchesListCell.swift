//
//  MatchesListCell.swift
//  Mentor-iOS
//
//  Created by Melody on 3/29/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

class MatchesListCell: UICollectionViewCell {
    
    var viewModel: MessageItemViewModel! {
        didSet {
            nameLabel.text = viewModel?.name
            roleLabel.text = (viewModel?.role)! + " for \(viewModel.years) year(s)"
            companyInputLabel.text = (viewModel?.company)!
            goalInputLabel.text = viewModel.goal
            profileImageView.getImageFromURL(url: (viewModel?.image)!)
            bgView.getImageFromURL(url: (viewModel?.image)!)
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roleLabel: UILabel = {
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
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "Profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    let connectButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Connect", for: .normal)
        button.backgroundColor = UIColor.violetBlue
        button.addShadow()
        button.makeRounded()
        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        return button
    }()
    
    @objc func touchDown(sender: UIButton) {
        sender.backgroundColor = UIColor.white
        sender.setTitleColor(UIColor.violetBlue, for: UIControlState.normal)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpBackgroundView()
        setUpViews()
       
    }
    
    var bgView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.clear
        view.addBlurEffect()
        return view
    }()
    
   
    func setUpViews() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(roleLabel)
        addSubview(companyInputLabel)
        addSubview(goalLabel)
        addSubview(connectButton)
        addSubview(companyLabel)
        addSubview(goalInputLabel)
        
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 80).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
    
        roleLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 30).isActive = true
        roleLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor).isActive = true
        
        
        companyLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 220, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        companyInputLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        companyInputLabel.topAnchor.constraint(equalTo: companyLabel.topAnchor, constant: 20).isActive = true
        
        goalLabel.leftAnchor.constraint(equalTo: companyLabel.leftAnchor).isActive = true
        goalLabel.topAnchor.constraint(equalTo: topAnchor, constant: 280).isActive = true
        goalInputLabel.leftAnchor.constraint(equalTo: goalLabel.leftAnchor).isActive = true
        goalInputLabel.topAnchor.constraint(equalTo: goalLabel.topAnchor, constant: 20).isActive = true

        connectButton.translatesAutoresizingMaskIntoConstraints = false
        connectButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 200).isActive = true
        connectButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        connectButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        connectButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
    }
    
    func setUpBackgroundView() {
        addSubview(bgView)
        bgView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 210)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}





