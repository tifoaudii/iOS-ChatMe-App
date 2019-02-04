//
//  AvatarPickerVC.swift
//  SmackChat
//
//  Created by Tifo Audi Alif Putra on 30/01/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var avatarCollection: UICollectionView!
    
    //default avatar's type
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avatarCollection.delegate = self
        avatarCollection.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AVATAR_CELL, for: indexPath) as? AvatarCell {
            cell.setupAvatarCell(index: indexPath.item, type: avatarType)
            return cell
        } else {
            return AvatarCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserService.instance.updateAvatar(name: "dark\(indexPath.item)")
        } else {
            UserService.instance.updateAvatar(name: "light\(indexPath.item)")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Create dynamic size for each cell based on the screen's width
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numOfColumns: CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numOfColumns = 4
            
        }
        
        let spaceBetweenCells: CGFloat = 10
        let padding: CGFloat = 40
        let cellDimension: CGFloat = ((collectionView.bounds.width - padding) - ((numOfColumns-1)*spaceBetweenCells)) / numOfColumns
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            avatarType = .dark
        } else {
            avatarType = .light
        }
        avatarCollection.reloadData()
    }
}
