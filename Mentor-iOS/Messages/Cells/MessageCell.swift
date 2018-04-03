//
//  MessageTableCell.swift
//  Mentor-iOS
//
//  Created by Melody on 3/31/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    var viewModel: UserItemViewModel! {
        didSet {
            nameLabel.text = viewModel?.name
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        
    }
    
    func setUpViews() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        
        //        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 130).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
//        nameLabel.leftAnchor.constraint(equalTo: profileImageView.leftAnchor).isActive = true
//        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 110).isActive = true
//        nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
//        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        //        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 5).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
