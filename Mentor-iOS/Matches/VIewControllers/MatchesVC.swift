//
//  MatchesVC.swift
//  Mentor-iOS
//
//  Created by Melody on 3/28/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation
import UIKit
import Koloda

class MatchesVC: UIViewController {
    
//    let matchesVC = MatchesVC(coder: UICollectionViewFlowLayout())

//    var collectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
    
    var collectionView: UICollectionView!
    
    var dataSource = GenericCollectionViewDatasource<UserItemViewModel>()
    let viewModel = MatchesViewModel()
    var userItems = [UserItemViewModel]()
    
    let cellID = "matchesCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.gray
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        
        collectionView.register(MatchesListCell.self, forCellWithReuseIdentifier: cellID)
        
        registerCollectionView()

    }
    
    func registerCollectionView() {
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        viewModel.fetchUsers(callback: { [unowned self] (users) in
            self.dataSource.items = users
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        dataSource.configureCell = { cv, indexPath in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! MatchesListCell
            return cell
        }
        
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: 8, paddingBottom: 50, paddingRight: 8, width: 0, height: 200)
    }
    
    func setUpView() {
        let screenHeight = UIScreen.main.bounds.height
//        view.addSubview(collectionView)
       
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: 8, paddingBottom: 50, paddingRight: 8, width: 0, height: 200)
        
    }
    

}

extension MatchesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedUser = dataSource.items[indexPath.row]
//        goToDetailController(selectedMemo: selectedMemo)
    }
    
    // cell size and position
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }

    
}


