//
//  MatchesVC.swift
//  Mentor-iOS
//
//  Created by Melody on 3/28/18.
//  Copyright © 2018 Melody Yang. All rights reserved.
//

import Foundation
import UIKit
import UPCarouselFlowLayout

class MatchesVC: UIViewController {
    
    var collectionView: UICollectionView!
    
    var dataSource = GenericCollectionViewDatasource<UserItemViewModel>()
    let viewModel = MatchesViewModel()
    var userItems = [UserItemViewModel]()
    
    let cellID = "matchesCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.gray
//        setUpCarouselLayout()
        registerCollectionView()
       
        

    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        DispatchQueue.main.async {
//            self.collectionView.reloadData()
////            print("item: \(self.userItems)")
//        }
//    }
    
    func setUpCarouselLayout() {
        let layout = UPCarouselFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
        layout.sideItemScale = 0.7
        layout.sideItemAlpha = 0.4
        layout.sideItemShift = 0.5
        
    }
    
    func registerCollectionView() {
        
        
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.register(MatchesListCell.self, forCellWithReuseIdentifier: cellID)
        flowLayout.scrollDirection = .horizontal
        
        viewModel.fetchUsers(callback: { [unowned self] (users) in
            self.dataSource.items = users
            self.userItems = users
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        
        dataSource.configureCell = { cv, indexPath in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! MatchesListCell
            cell.viewModel = self.userItems[indexPath.section]
            return cell
        }
        
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: 8, paddingBottom: 50, paddingRight: 8, width: 0, height: 200)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
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
        return CGSize(width: view.frame.width, height: 500)
    }
    
    

    
}


