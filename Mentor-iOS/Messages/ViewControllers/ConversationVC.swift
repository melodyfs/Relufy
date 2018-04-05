//
//  ConversationVC.swift
//  Mentor-iOS
//
//  Created by Melody on 4/3/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import UIKit
import PusherSwift

class ConversationVC: UIViewController, PusherDelegate {

    var collectionView: UICollectionView!
    var pusher: Pusher!
    var dataSource = GenericCollectionViewDatasource<ConversationItemViewModel>()
    var viewModel = ConversationViewModel()
    let cell = "convCell"
    var convs = [ConversationItemViewModel]()
    var userInfo = [MessageItemViewModel]()
    var otherPersonEmail: String!
    var userDefault = UserDefaults.standard
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a message..."
        return textField
    }()
    
    let messageContainerView: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return button
    }()
    
    var buttomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.channelName = ["channel_name": "private-\(otherPersonEmail!)-kate@test.com"]
        registerCollectionView()
        fetchMessages()
        configureCell()

        view.addSubview(messageContainerView)

        messageContainerView.translatesAutoresizingMaskIntoConstraints = false
        messageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        messageContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        messageContainerView.heightAnchor.constraint(equalTo: collectionView.heightAnchor, constant: -550).isActive = true
        buttomConstraint = messageContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        buttomConstraint?.isActive = true
        
        setUpInputComponent()
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationKeyboard(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotificationKeyboard(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func handleSend() {
        let message = ConversationItemViewModel(sender: "kate@test.com", content: inputTextField.text!)
        let sec = collectionView.dataSource?.numberOfSections!(in: collectionView)
    
        dataSource.items.append(message)

        let section = dataSource.items.count
        self.collectionView?.insertSections([section - 1])

    }
    
    @objc func handleNotificationKeyboard(notification: NSNotification) {
        
        if let userinfo = notification.userInfo {
            let keyboardSize = (userinfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let isKeyboardShowing = notification.name == Notification.Name.UIKeyboardWillShow
            buttomConstraint?.constant = isKeyboardShowing ? -(keyboardSize?.height)! + 48 : 0
            UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()

            }, completion: {completed in
                if isKeyboardShowing {
                    let indexPath = NSIndexPath(item: 0, section: self.convs.count - 1)
                    self.collectionView.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
                }
            })
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        configureCell()
        //        chan.trigger(eventName: "client-test", data: ["test": "some value"])
    }
    
    func setUpInputComponent() {
        messageContainerView.addSubview(inputTextField)
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.anchor(top: messageContainerView.topAnchor, left: messageContainerView.leftAnchor, bottom: messageContainerView.bottomAnchor, right: messageContainerView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 200, height: 0)
        messageContainerView.addSubview(sendButton)
        sendButton.anchor(top: messageContainerView.topAnchor, left: messageContainerView.leftAnchor, bottom: messageContainerView.bottomAnchor, right: messageContainerView.rightAnchor, paddingTop: 0, paddingLeft: 310, paddingBottom: 0, paddingRight: 0, width: 10, height: 0)
        
    }
    
    //Send a message thru server
    func connectPusher() {
        ServerNetworking.shared.getInfo(route: .sendMessage, params: ["channel_name": "private-\(otherPersonEmail!)-kate@test.com", "content": "test ios", "event": "test"]) { _ in }
        ServerNetworking.shared.getInfo(route: .saveMessage, params:["channel_name": "private-\(otherPersonEmail!)-kate@test.com", "content": "test ios", "event": "test"]) { _ in }
    }
    
    func registerCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.register(ConversationCell.self, forCellWithReuseIdentifier: cell)
        flowLayout.scrollDirection = .vertical
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        
        fetchMessages()
        
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 300)
        
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
            //TODO: Which image - user's or other person's
            cell.profileImageView.getImageFromURL(url: self.userInfo[indexPath.row].image)
//            self.otherPersonEmail = self.userInfo[indexPath.row].email
            return cell
        }
    }

    
    func fetchMessages() {
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
        
        let chan = pusher.subscribe("private-\(otherPersonEmail!)-kate@test.com")
        
        let _ = chan.bind(eventName: "test", callback: { data in
            print(data)
            //TODO: append message and insert item
            //            let _ = self.pusher.subscribe("private-\(mentorEmail)-\(menteeEmail)")
//            let _ = self.pusher.subscribe("private-\(self.otherPersonEmail!)-kate@test.com")
//            if let data = data as? [String : AnyObject] {
//                if let testVal = data["test"] as? String {
//
//                }
//            }
        })
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ConversationVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension ConversationVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedUser = dataSource.items[indexPath.section]
        print(indexPath)
    }
    
    // cell size and position
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width, height: 100)
        
    }
    
}

