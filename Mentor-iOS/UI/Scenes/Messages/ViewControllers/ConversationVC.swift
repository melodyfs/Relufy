//
//  ConversationVC.swift
//  Mentor-iOS
//
//  Created by Melody on 4/3/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit
import PusherSwift
import KeychainSwift

class ConversationVC: UIViewController, PusherDelegate, UITextViewDelegate {

    var collectionView: UICollectionView!
    var pusher: Pusher!
    var dataSource = GenericCollectionViewDatasource<ConversationItemViewModel>()
    var viewModel = ConversationViewModel()
    let cell = "convCell"
    var convs = [ConversationItemViewModel]()
    var userInfo = [MessageItemViewModel]()
    var otherPersonEmail: String!
    var userDefault = UserDefaults.standard
    let keys = AppKeys.instance
    let userEmail = KeychainSwift().get("email")
    var channelName = ""
    
    let inputTextField: UITextView = {
        let textField = UITextView()
        textField.text = "Enter a message..."
        textField.textColor = UIColor.lightGray
        textField.isEditable = true
        textField.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)

        return textField
    }()

    let messageContainerView: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let infoContainerView: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.violetBlue, for: .normal)
//        button.setTitleColor(UIColor.violetPurple, for: .touchUpInside)
        button.setTitle("Send", for: .normal)
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return button
    }()
    
    var buttomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        if keys.isMentor {
            viewModel.channelName = ["channel_name": "private-\(userEmail!)-\(otherPersonEmail!)"]
            channelName = "private-\(userEmail!)-\(otherPersonEmail!)"
        } else {
            viewModel.channelName = ["channel_name": "private-\(otherPersonEmail!)-\(userEmail!)"]
            channelName = "private-\(otherPersonEmail!)-\(userEmail!)"
        }

        registerCollectionView()
        listenToMessages()
        configureCell()
        setUpLayout()
        inputTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationKeyboard(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationKeyboard(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func setUpLayout()  {
        view.addSubview(messageContainerView)

        messageContainerView.translatesAutoresizingMaskIntoConstraints = false
        messageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        messageContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        messageContainerView.heightAnchor.constraint(equalTo: collectionView.heightAnchor, constant: -550).isActive = true
        buttomConstraint = messageContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        buttomConstraint?.isActive = true
        
        setUpInputComponent()
        hideKeyboardWhenTappedAround()
    }
    
    @objc func handleSend() {
        let message = ConversationItemViewModel(sender: "\(userEmail!)", content: inputTextField.text!)
        dataSource.items.append(message)
        
        let section = dataSource.items.count
        self.collectionView?.insertSections([section - 1])
        sendMessage()
        inputTextField.text = nil
        buttomConstraint?.constant = 0
        dismissKeyboard()
    }
    
    //Send & save a message thru server
    func sendMessage() {
        ServerNetworking.shared.getInfo(route: .sendMessage, params: ["channel_name": channelName, "content": inputTextField.text!, "event": "chat", "sender": userEmail!]) { _ in }
        ServerNetworking.shared.getInfo(route: .saveMessage, params:["channel_name": channelName, "content": inputTextField.text!, "event": "chat", "sender": userEmail!]) { _ in }
    }
    
    @objc func handleNotificationKeyboard(notification: NSNotification) {
        
        if let userinfo = notification.userInfo {
            let keyboardSize = (userinfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let isKeyboardShowing = notification.name == Notification.Name.UIKeyboardWillShow
            buttomConstraint?.constant = isKeyboardShowing ? -(keyboardSize?.height)!: 0
            UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()

            }, completion: {completed in
                if isKeyboardShowing {
                    if self.dataSource.items.count != 0 {
                        let indexPath = NSIndexPath(item: 0, section: self.dataSource.items.count - 1)
                        self.collectionView.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
                    }
                   
                }
            })
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        configureCell()
    }
    
    func listenToMessages() {
        let options = PusherClientOptions(
            authMethod: AuthMethod.authRequestBuilder(authRequestBuilder: AuthRequestBuilder()),
            host: .cluster(cluster)
        )
        pusher = Pusher(
            key: key,
            options: options
        )
        pusher.delegate = self
        pusher.connect()
        
        let chan = pusher.subscribe(channelName)
        let _ = chan.bind(eventName: "chat", callback: { data in
            print(data)
            if let data = data as? [String : AnyObject] {
                if let sender = data["sender"] as? String {
                    if let content = data["content"] as? String {
                        let message = ConversationItemViewModel(sender: sender, content: content)
                        self.dataSource.items.append(message)
                        let section = self.dataSource.items.count
                        self.collectionView?.insertSections([section - 1])
                    }
                }
            }
        })
        
    }
    
    func setUpInputComponent() {
        messageContainerView.addSubview(inputTextField)
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.anchor(top: messageContainerView.topAnchor, left: messageContainerView.leftAnchor, bottom: messageContainerView.bottomAnchor, right: messageContainerView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 80, width: 200, height: 0)
        messageContainerView.addSubview(sendButton)
        sendButton.anchor(top: messageContainerView.topAnchor, left: messageContainerView.leftAnchor, bottom: messageContainerView.bottomAnchor, right: messageContainerView.rightAnchor, paddingTop: 0, paddingLeft: 320, paddingBottom: 0, paddingRight: 0, width: 10, height: 0)
        
    }
    
    func registerCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.register(ConversationCell.self, forCellWithReuseIdentifier: cell)
        flowLayout.scrollDirection = .vertical
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        
        listenToMessages()
        
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 60, paddingLeft: 0, paddingBottom: 35, paddingRight: 0, width: 200, height: 300)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
    }
    
    
    func configureCell() {
        
        viewModel.fetchConversation(callback: { [unowned self] (conv) in
            self.dataSource.items = conv
            self.convs = conv
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })

        dataSource.configureCell = { cv, indexPath in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cell, for: indexPath) as! ConversationCell
            cell.viewModel = self.dataSource.items[indexPath.section]
            let email = self.dataSource.items[indexPath.section].sender
            if email == self.otherPersonEmail! {
                cell.profileImageView.getImageFromURL(url: self.userInfo[indexPath.row].image)
            } else {
                //TODO: change to current user's
                cell.profileImageView.getImageFromURL(url: keychain.get("image")!)
            }
            return cell
        }
    }

}

extension ConversationVC: UICollectionViewDelegateFlowLayout {
    // cell size and position
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width, height: 100)
        
    }
    
}



