//
//  ManagersSpecialsViewController.swift
//  HasanPrestoQ
//
//  Created by Hasan D Edain on 3/19/19.
//  Copyright © 2019 NPC Unlimited. All rights reserved.
//

import UIKit
import os.log

class ManagersSpecialsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, DataManagerDelegate {
    @IBOutlet weak var downloadActivityView: UIActivityIndicatorView!
    
    let cellIdentifier = "ManagerSpecialCell"

    let dataManager = DataManager()
    var managerSpecials: ManagersSpecials?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.dataManagerDelegate = self
        dataManager.start()
    }

    func managersSpecialsDataReceived(specials: ManagersSpecials) {
        self.managerSpecials = specials
        self.collectionView.reloadData()
        downloadActivityView.stopAnimating()
    }

    func fetchFailed() {
        //TODO: message user
        downloadActivityView.stopAnimating()
    }

    //MARK: - UICollectionView
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if let managerSpecials = self.managerSpecials {
            return managerSpecials.count()
        }

        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)

        if let managerSpecialCell = cell as? ManagerSpecialCollectionViewCell {
            if let managerSpecial = managerSpecials?.specialAtIndex(index: indexPath.row) {
                managerSpecialCell.configure(managerSpecial: managerSpecial)
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxCellWidth = CGFloat(collectionView.frame.size.width)
        let defaultHeight: CGFloat = 128.0
        var size = CGSize(width: maxCellWidth, height: defaultHeight)
        let canvasUnit: CGFloat
        if let managerSpecials = managerSpecials {
            canvasUnit = CGFloat(managerSpecials.canvasUnit)
        } else {
            canvasUnit = 8
        }
        let canvasUnitPoints = maxCellWidth / canvasUnit

        if let managerSpecial = managerSpecials?.specialAtIndex(index: indexPath.row) {
            let canvasUnitHeight = CGFloat(managerSpecial.height)
            let canvasUnitWidth = CGFloat(managerSpecial.width)
            var lineSpacing: CGFloat
            if let layout =  collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                lineSpacing = layout.minimumInteritemSpacing + layout.sectionInset.left + layout.sectionInset.right
            } else {
                lineSpacing = 10.0
            }

            let cellWidth = (canvasUnitWidth * canvasUnitPoints) - lineSpacing
            //TODO: preserve the aspect ratio of the cell better than just removing the same number of pixels?
            let cellHeight = canvasUnitHeight * canvasUnitPoints - lineSpacing
            size = CGSize(width: cellWidth, height: cellHeight)
        }

        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
        return headerView
    }

}
