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
            companyLabel.text = "Current Company: " + (viewModel?.company)!
            profileImageView.getImageFromURL(url: (viewModel?.image)!)
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
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
    
    let companyLabel: UILabel = {
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
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis  = UILayoutConstraintAxis.horizontal
        sv.alignment = UIStackViewAlignment.center
        sv.distribution = UIStackViewDistribution.fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false;
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        
    }
    
    func setUpViews() {
        backgroundColor = UIColor.orange

        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(roleLabel)
        addSubview(companyLabel)
        
//        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 130).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
//        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 110).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: -90).isActive = true
//        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 5).isActive = true
        
//        roleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
    
        roleLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 30).isActive = true
        roleLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor).isActive = true
        
        companyLabel.leftAnchor.constraint(equalTo: roleLabel.leftAnchor).isActive = true
        companyLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 50).isActive = true
        companyLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}


