//
//  MessageTableCell.swift
//  Mentor-iOS
//
//  Created by Melody on 3/31/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    var viewModel: MessageItemViewModel! {
        didSet {
            nameLabel.text = viewModel?.name
            profileImageView.getImageFromURL(url: (viewModel?.image)!)
        }
    }
    
    let nameLabel: UILabel = {
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
        imageView.layer.cornerRadius = 40
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
        
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.leftAnchor, constant: 100).isActive = true
//        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
//        nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        //        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 5).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
