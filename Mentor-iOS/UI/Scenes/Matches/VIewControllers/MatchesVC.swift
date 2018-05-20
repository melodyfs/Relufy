//
//  MatchesVC.swift
//  Mentor-iOS
//
//  Created by Melody on 3/28/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift

class MatchesVC: UIViewController {
    
    var collectionView: UICollectionView!
    var dataSource = GenericCollectionViewDatasource<MessageItemViewModel>()
    let viewModel = MessageViewModel()
    let cellID = "matchesCell"
    var matchIDs = [Int]()
    let keychain = KeychainSwift()
    let keys = AppKeys.instance
    var emptyView: UIView!
    var userInfo = [MessageItemViewModel]()
    let screenSize = UIScreen.main.bounds
    let userDefault = UserDefaults.standard
    var menteeMatchIDs = [Int]()
    var menteeUserInfo = [MessageItemViewModel]()
    lazy var appDelegate = AppDelegateViewModel.instance
   
    
    @objc func handleValueChange(sender: UISegmentedControl) {
        collectionView.dataSource = nil
        switch sender.selectedSegmentIndex {
        case 0:
            keys.setMentorOrMentee(isMentor: false)
//            appDelegate.changeStatus(authStatus: .authorized)
           
            userDefault.set(0, forKey: "segNum")
            print("value change")
        case 1:
            keys.setMentorOrMentee(isMentor: true)
//            appDelegate.changeStatus(authStatus: .authorized)
//            fetchMenteeMessages()
            configureCell()
            userDefault.set(1, forKey: "segNum")
            print("value change")
        default:
            break
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keys.setMentorOrMentee(isMentor: keys.isMentor)
        viewModel.confirmed = ["confirmed": "false"]
        view.backgroundColor = UIColor.white
        registerCollectionView()
        setNameAndImage()
        navigationController?.navigationBar.prefersLargeTitles = true
//        addChangeRoleBarButton()
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            UIViewController.removeSpinner(spinner: sv)
        }
    }
    
    func addSegmentedControl() {
        let items = ["Mentors", "Mentees"]
        let customSC = UISegmentedControl(items: items)
        let normalFont = UIFont.systemFont(ofSize: 16)
        let normalTextAttributes: [NSObject : AnyObject] = [
            NSAttributedStringKey.font as NSObject: normalFont]
        customSC.backgroundColor = UIColor.clear
        customSC.tintColor = UIColor.violetBlue
        customSC.setTitleTextAttributes(normalTextAttributes, for: .normal)
        customSC.selectedSegmentIndex = userDefault.integer(forKey: "segNum")
        customSC.frame = CGRect(x: 0, y: 0, width: 400, height: 40)
        customSC.addTarget(self, action: #selector(handleValueChange), for: .valueChanged)
        navigationItem.title = nil
        navigationItem.titleView = customSC
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.confirmed = ["confirmed": "false"]
        registerCollectionView()
        ServerNetworking.shared.getInfo(route: .createMatches, params: [:]) {_ in}
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        if keys.isMentor {
            self.navigationItem.title = "Mentees"
        } else {
            self.navigationItem.title = "Mentors"
        }
        
        
    }
    
    var getStartedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Check Back Soon For New Matches!"
        return label
    }()
    
    func setUpBgLabel() {
        collectionView.addSubview(getStartedLabel)
        getStartedLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        getStartedLabel.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        
    }
    
    func registerCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.register(MatchesListCell.self, forCellWithReuseIdentifier: cellID)
        flowLayout.scrollDirection = .vertical
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        
        fetchUsers()
        configureCell()
        
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        self.view.addSubview(collectionView)
        let tabBarHeight = CGFloat((tabBarController?.tabBar.frame.size.height)!)
//        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 120, paddingLeft: 0, paddingBottom: -tabBarHeight, paddingRight: 0, width: 0, height: 0)
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: topBarHeight).isActive = true
//        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 50).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarHeight).isActive = true
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    func fetchUsers() {
        viewModel.fetchMatches(callback: { [unowned self] (users) in
            self.userInfo = users
            self.dataSource.items = self.userInfo
            self.matchIDs = self.viewModel.matchIDs
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        
       
    }
    
   
    
    func configureCell() {
        let sv = UIViewController.displaySpinner(onView: self.view)

        dataSource.configureCell = { cv, indexPath in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! MatchesListCell
            cell.viewModel = self.dataSource.items[indexPath.section]
            cell.addShadow()
            cell.roundCorner()
            return cell
        }
        
         UIViewController.removeSpinner(spinner: sv)
    }
    
    func setNameAndImage() {
        if AppKeys.instance.isMentor {
            ServerNetworking.shared.getInfo(route: .getMentorImage, params: [:]) { info in
                if let userinfo = try? JSONDecoder().decode([User].self, from: info) {
                    UserDefaults.standard.set((userinfo.first?.image_file)!, forKey: "image")
                    UserDefaults.standard.set(userinfo.first?.name, forKey: "name")
                }
            }
        } else {
            ServerNetworking.shared.getInfo(route: .getMenteeImage, params: [:]) { info in
                if let userinfo = try? JSONDecoder().decode([User].self, from: info){
                    UserDefaults.standard.set((userinfo.first?.image_file)!, forKey: "image")
                    UserDefaults.standard.set(userinfo.first?.name, forKey: "name")
                }
            }
        }
        
    }
    
    func addChangeRoleBarButton() {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "role"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(handleChange), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 55, height: 50)
        
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func handleChange() {
        print("change")
        let actionSheet = UIAlertController(
            title: "Switch Your Role",
            message: nil,
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(
            UIAlertAction(
                title: "Be a Mentee",
                style: .default,
                handler: { _ in
                print("mentors")
                self.keys.setMentorOrMentee(isMentor: false)
                self.appDelegate.changeStatus(authStatus: .authorized)
                
                print("value change")
            })
        )
        actionSheet.addAction(
            UIAlertAction(
                title: "Be a Mentor",
                style: .default,
                handler: { _ in
                self.keys.setMentorOrMentee(isMentor: true)
                self.appDelegate.changeStatus(authStatus: .authorized)
            })
        )
        
        actionSheet.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: { _ in
                
            })
        )
        
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    

}

extension MatchesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedUser = dataSource.items[indexPath.section]
        let personDetailVC = PersonDetailVC()
        personDetailVC.selectedUser = [selectedUser]
        navigationController?.pushViewController(personDetailVC, animated: true)
    }
    
    // cell size and position
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width - 20, height: frameSize.height / 2.7)

    }
    
    // padding for cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    }
    
}



