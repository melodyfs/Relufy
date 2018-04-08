//
//  OpenningVC.swift
//  Mentor-iOS
//
//  Created by Melody on 4/6/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

class OpenningVC: UIViewController {
    
    let keys = AppKeys.instance
    
    let optionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "I'd like to ..."
        return label
    }()
    
    let giveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Give advices", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(giveOrReceive), for: .touchUpInside)
        return button
    }()
    
    let receiveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Receive advices", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(giveOrReceive), for: .touchUpInside)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Next >", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc func giveOrReceive(sender: UIButton) {
        let buttons = [giveButton, receiveButton]
        buttons.forEach {
            $0.isSelected = false
            $0.backgroundColor = UIColor.clear
            //            $0.setTitleColor(UIColor.white, for: .normal)
        }
        
        sender.isSelected = true
        if sender.isSelected {
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(UIColor.violetBlue, for: .selected)
        }
        
    }
    
    @objc func handleNext() {
        if giveButton.isSelected {
            keys.setMentorOrMentee(isMentor: true)
        } else {
            keys.setMentorOrMentee(isMentor: false)
        }
        
        let loginVC = LoginVC()
        self.present(loginVC, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        view.addSubview(optionLabel)
        view.addSubview(giveButton)
        view.addSubview(receiveButton)
        view.addSubview(nextButton)
        
        optionLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 200, paddingLeft: 55, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        giveButton.anchor(top: optionLabel.topAnchor, left: optionLabel.leftAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        receiveButton.anchor(top: giveButton.topAnchor, left: giveButton.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 130, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150).isActive = true
    }
    



}
