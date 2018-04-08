//
//  Extension+ConversationVC.swift
//  Mentor-iOS
//
//  Created by Melody on 4/6/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit

extension ConversationVC {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ConversationVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if inputTextField.text == "" {
            
            inputTextField.text = "Enter your message ..."
            inputTextField.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if inputTextField.textColor == UIColor.lightGray {
            inputTextField.text = ""
            inputTextField.textColor = UIColor.black
        }
    }
    

}


