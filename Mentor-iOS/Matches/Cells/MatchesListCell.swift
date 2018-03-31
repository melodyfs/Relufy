//
//  MatchesListCell.swift
//  Mentor-iOS
//
//  Created by Melody on 3/29/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

class MatchesListCell: UICollectionViewCell {
    
    var viewModel: UserItemViewModel! {
        didSet {
            self.nameLabel.text = viewModel?.name
            self.roleLabel.text = viewModel?.role
            self.companyLabel.text = viewModel?.company
            self.profileImageView.getImageFromURL(url: (viewModel?.image)!)
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "Profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
//
//        addSubview(nameLabel)
//        addSubview(roleLabel)
//        addSubview(companyLabel)
//        addSubview(profileImageView)
        
//        nameLabel.text = "Melody"
//        roleLabel.text = "Software Dev"
//        companyLabel.text = "Apple"
        
        let stackView = UIStackView(arrangedSubviews: [profileImageView, nameLabel, roleLabel, companyLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
