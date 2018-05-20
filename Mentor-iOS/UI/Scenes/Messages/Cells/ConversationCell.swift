//
//  ConversationCell.swift
//  Mentor-iOS
//
//  Created by Melody on 4/3/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

class ConversationCell: UICollectionViewCell {
    
    var viewModel: ConversationItemViewModel! {
        didSet {
            messageTextView.text = viewModel.content
//            nameLabel.text = viewModel?.content
        }
    }
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Sample text"
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.sizeToFit()
        textView.isUserInteractionEnabled = false

        return textView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.text = "Name"
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "Profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5/7/18 12:10"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        
    }
    
    func setUpViews() {
//        backgroundColor = UIColor.lightGray
        addSubview(messageTextView)
        addSubview(profileImageView)
        addSubview(nameLabel)
//        addSubview(timeLabel)
        
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        messageTextView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 25, paddingLeft: 55, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 60).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        
//        timeLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 20 + nameLabel.intrinsicContentSize.width).isActive = true
//        timeLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 4).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
