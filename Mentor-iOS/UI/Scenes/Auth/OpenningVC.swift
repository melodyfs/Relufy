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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Relate. Accelerate."
        return label
    }()
    
    let optionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "I'd like to ..."
        return label
    }()
    
    let giveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Give advices", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        button.addTarget(self, action: #selector(giveOrReceive), for: .touchUpInside)
        button.addBorder(color: UIColor.white)
        button.makeRounded()
        return button
    }()
    
    let receiveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Receive advices", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(giveOrReceive), for: .touchUpInside)
        button.addBorder(color: UIColor.white)
        button.makeRounded()
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Next >", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 27)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.addTarget(self, action: #selector(touchDown), for: .touchDown)
        return button
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.image = UIImage(named: "whiteIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    
    @objc func touchDown(sender: UIButton) {
        sender.setTitleColor(UIColor.violetPurple, for: UIControlState.normal)
    }
    
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
    
    @objc func handleNext(sender: UIButton) {
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
        giveOrReceive(sender: giveButton)
    }
    
    func setUpViews() {
        view.addSubview(titleLabel)
        view.addSubview(optionLabel)
        view.addSubview(giveButton)
        view.addSubview(receiveButton)
        view.addSubview(nextButton)
        view.addSubview(iconImageView)
        
        
        iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70).isActive = true
        
        optionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        optionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        
        giveButton.translatesAutoresizingMaskIntoConstraints = false
        giveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        giveButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80).isActive = true
        giveButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        receiveButton.translatesAutoresizingMaskIntoConstraints = false
        receiveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        receiveButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 140).isActive = true
        receiveButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 250).isActive = true
    }
    

    



}
