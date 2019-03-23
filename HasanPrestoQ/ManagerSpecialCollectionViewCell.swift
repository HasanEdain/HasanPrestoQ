//
//  ManagerSpecialCollectionViewCell.swift
//  HasanPrestoQ
//
//  Created by Hasan D Edain on 3/20/19.
//  Copyright © 2019 NPC Unlimited. All rights reserved.
//

import UIKit
import CoreGraphics
import os.log

class ManagerSpecialCollectionViewCell: UICollectionViewCell, PrestoQFetcherDelegate {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!

    var managerSpecial: ManagerSpecial?
    var imageFetcher: PrestoQFetcher?

    func configure(managerSpecial: ManagerSpecial) {

        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.25
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath

        self.managerSpecial = managerSpecial
        //TODO: cache fetched images and don't refetch on a scroll
        fetchProductImage()
        updateUserInterface()

    }

    func updateUserInterface() {
        if let special = self.managerSpecial {
            //TODO: Fetch Product image from URL
            //TODO: Use a decimal formatter and locale for prices
            if let originalPrice = managerSpecial?.original_price {
                originalPriceLabel.attributedText = ManagerSpecial.strikethroughAttributedString(numberString: originalPrice)
            }

            if let price = managerSpecial?.price {
                priceLabel.attributedText = ManagerSpecial.attributedString(numberString: price)
            }

            // TODO: for wider cell layouts wrap description
            displayNameLabel.text = special.display_name


            productImage.accessibilityLabel = "\(special.display_name)"
        }
    }

    func fetchProductImage() {
        guard let special = self.managerSpecial else {
            assert(false, "manager special must exist")
            return
        }
        let urlString = special.imageUrl
        if let url = URL(string: urlString) {
            if imageFetcher == nil {
                imageFetcher = PrestoQFetcher(delegate: self)
                imageFetcher?.fetchEndpoint(url: url)
            }
        }
    }

    func dataReceived(data: Data) {
        if let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.productImage.image = image
            }
        } else {
            os_log("could not create image from data")
        }
    }

    func errorReceived(error: Error) {
        os_log("Error retreiving image: %@", error.localizedDescription)
    }

}
