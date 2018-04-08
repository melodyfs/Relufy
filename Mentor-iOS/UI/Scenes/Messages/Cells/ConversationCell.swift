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
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "Profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        
    }
    
    func setUpViews() {
//        backgroundColor = UIColor.lightGray
        addSubview(messageTextView)
        addSubview(profileImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        messageTextView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 55, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
//        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
