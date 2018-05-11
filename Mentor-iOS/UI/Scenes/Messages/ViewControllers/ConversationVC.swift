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
        textField.sizeToFit()
        return textField
    }()

    let messageContainerView: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor.violetBlue, for: .normal)
        button.setTitle("Send", for: .normal)
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return button
    }()
    
    var buttomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setChannelName()
        registerCollectionView()
        listenToMessages()
        configureCell()
        setUpLayout()
        inputTextField.delegate = self
        addNotifications()
        addProfileButton()
    }
    
    func addProfileButton() {
        let button = UIButton.init(type: .custom)
        
//        button.imageView?.sizeToFit()
        
        if userInfo.first!.image == "/image_files/original/missing.png" {
            button.setImage(UIImage(named: "role"), for: UIControlState.normal)
        } else {
            let url = URL(string: userInfo.first!.image)
            button.kf.setImage(with: url, for: .normal, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.layer.masksToBounds = false
        button.imageView?.layer.cornerRadius = 15
        button.imageView?.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        button.addTarget(self, action: #selector(showProfile), for: UIControlEvents.touchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func showProfile() {
//        let selectedUser = dataSource.items[indexPath.section]
        let personDetailVC = ProfileDetailsVC()
        personDetailVC.selectedUser = userInfo
        navigationController?.pushViewController(personDetailVC, animated: true)
//        navigationController?.pushViewController(PersonDetailVC, animated: true)
        
    }
    
    func setChannelName() {
        if keys.isMentor {
            viewModel.channelName = ["channel_name": "private-\(userEmail!)-\(otherPersonEmail!)"]
            channelName = "private-\(userEmail!)-\(otherPersonEmail!)"
        } else {
            viewModel.channelName = ["channel_name": "private-\(otherPersonEmail!)-\(userEmail!)"]
            channelName = "private-\(otherPersonEmail!)-\(userEmail!)"
        }
    }
    
    func addNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationKeyboard(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationKeyboard(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        tabBarController?.tabBar.isTranslucent = true
        NotificationCenter.default.addObserver(self, selector: #selector(listenToMessagesInBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    func setUpLayout()  {
        view.addSubview(messageContainerView)

        messageContainerView.translatesAutoresizingMaskIntoConstraints = false
        messageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        messageContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        messageContainerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        buttomConstraint = messageContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        buttomConstraint?.isActive = true
        
        setUpInputComponent()
        hideKeyboardWhenTappedAround()
    }
    
    @objc func handleSend() {
        if let content = inputTextField.text {
            let body = content
            let message = ConversationItemViewModel(sender: "\(userEmail!)", content: content)
            dataSource.items.append(message)
            let section = dataSource.items.count
            self.collectionView?.insertSections([section - 1])
            sendMessage(content: body)
            inputTextField.text = nil
            buttomConstraint?.constant = 0
            dismissKeyboard()
        }
    }
    
    //Send & save a message thru server
    func sendMessage(content: String) {
        ServerNetworking.shared.getInfo(route: .sendMessage, params: ["channel_name": channelName, "content": content, "event": "chat", "sender": userEmail!]) { _ in }
        ServerNetworking.shared.getInfo(route: .saveMessage, params:["channel_name": channelName, "content": content, "event": "chat", "sender": userEmail!]) { _ in }
        
//        notifyNewMessage(title: UserDefaults.standard.string(forKey: "name")!, body: content)
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
                        let indexPath = IndexPath(item: 0, section: self.dataSource.items.count - 1)
                        self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
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
                        self.notifyNewMessage(title: sender, body: content)
                    }
                }
            }
        })
        
    }
    
    @objc func listenToMessagesInBackground(notification: Notification) {
        print(notification.userInfo)
        print("app in forground")

    }
    
    func notifyNewMessage(title: String, body: String) {
        var params = ["title": title,
                      "body": body]
        ServerNetworking.shared.getInfo(route: .postNotification, params: params) {_ in}
    }
    
    
    func setUpInputComponent() {
        messageContainerView.addSubview(inputTextField)
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.anchor(top: messageContainerView.topAnchor, left: messageContainerView.leftAnchor, bottom: messageContainerView.bottomAnchor, right: messageContainerView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 80, width: 200, height: 0)
        messageContainerView.addSubview(sendButton)
        sendButton.anchor(top: messageContainerView.topAnchor, left: nil, bottom: messageContainerView.bottomAnchor, right: messageContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
        
    }
    
    override func viewDidLayoutSubviews() {
        messageContainerView.layer.addBorder(edge: .top, color: UIColor.gray, thickness: 0.5)
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
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: view.frame.size.height)
        
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
                cell.nameLabel.text = self.userInfo.first?.name
            } else {
                cell.profileImageView.getImageFromURL(url: UserDefaults.standard.string(forKey: "image")!)
                cell.nameLabel.text =  UserDefaults.standard.string(forKey: "name")
            }
            return cell
        }
    }

}

extension ConversationVC: UICollectionViewDelegateFlowLayout {
    
    // dynamic cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 100
        
        let text = self.dataSource.items[indexPath.section].content
        height = estimateFrameForText(text: text).height
        return CGSize(width: view.frame.width, height: height + 50)

    }
    //estimates each cell's height
    private func estimateFrameForText(text: String) -> CGRect {
        let height: CGFloat = 100
        let frameSize = collectionView.frame.size
        
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)]
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }

    
}



