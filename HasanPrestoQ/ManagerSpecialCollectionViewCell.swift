//
//  ManagerSpecialCollectionViewCell.swift
//  HasanPrestoQ
//
//  Created by Hasan D Edain on 3/20/19.
//  Copyright © 2019 NPC Unlimited. All rights reserved.
//

import UIKit
import SpriteKit
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
        DropShadowUtility.addDropShadow(cell: self)

        self.managerSpecial = managerSpecial
        //TODO: cache fetched images and don't refetch on a scroll
        fetchProductImage()
        updateUserInterface()
    }

    func updateUserInterface() {
        if let special = self.managerSpecial {
            if let originalPrice = managerSpecial?.original_price {
                let priceAttributedString = StringUtility.strikethroughAttributedPriceString(numberString: originalPrice)
                originalPriceLabel.attributedText = priceAttributedString
                originalPriceLabel.accessibilityLabel = "Original price"
                originalPriceLabel.accessibilityValue = "\(priceAttributedString.string))"
            }

            if let price = managerSpecial?.price {
                let priceAttributedString = StringUtility.attributedPriceString(numberString: price)
                priceLabel.attributedText = priceAttributedString
                priceLabel.accessibilityLabel = "Special price"
                priceLabel.accessibilityValue = "\(priceAttributedString.string)"
            }

            displayNameLabel.text = special.display_name
            productImage.isAccessibilityElement = true
            productImage.accessibilityValue = "\(special.display_name)"
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
//        DispatchQueue.main.async {
            //TODO: maybe put something on the default image to indicate data load failure?
//        }
        os_log("Error retreiving image: %@", error.localizedDescription)
    }
}
