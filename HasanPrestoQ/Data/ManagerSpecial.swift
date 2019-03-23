//
//  ManagerSpecial.swift
//  HasanPrestoQ
//
//  Created by Hasan D Edain on 3/19/19.
//  Copyright © 2019 NPC Unlimited. All rights reserved.
//

import Foundation

struct ManagerSpecial: Codable {
    let imageUrl: String
    let width: Int
    let height: Int
    let display_name: String
    //TODO: Change to type Decimal and use locale to present a properly internationalized interface.
    let original_price: String
    let price: String

    init(imageUrl: String, width: Int, height: Int, display_name: String, original_price: String, price: String) {
        self.imageUrl = imageUrl
        self.width = width
        self.height = height
        self.display_name = display_name
        self.original_price = original_price
        self.price = price
    }

    func urlForImage() -> URL? {
        if let url = URL(string: self.imageUrl) {
            if url.host == nil {
                return nil
            } else if url.scheme != "https" {
                return nil
            }
            return url
        } else {
            return nil
        }
    }

    func decimalPrice() -> Decimal {
        if let decimal = Decimal(string: price) {
            return decimal
        } else {
            return Decimal.nan
        }
    }

    func decimalOriginalPrice() -> Decimal {
        if let decimal = Decimal(string: original_price) {
            return decimal
        } else {
            return Decimal.nan
        }
    }

    //TODO: Refactor this out of this class to a parameterized utility struct
    static func attributedString(numberString: String) -> NSAttributedString {
        var resultString: NSAttributedString = NSAttributedString(string: "")

        if let double = Double(numberString) {
            let numberFormatter = NumberFormatter()
            numberFormatter.locale = Locale.current
            numberFormatter.numberStyle = .currency
            let nsNumber = NSNumber(value: double)
            if let numberString = numberFormatter.string(from: nsNumber) {
                resultString = NSAttributedString(string: numberString)
            }
        }

        return resultString
    }

    //TODO: Refactor this out of this class to a parameterized utility struct
    static func strikethroughAttributedString(numberString:String) -> NSAttributedString {
        let originalString = attributedString(numberString: numberString)
        let newString = NSMutableAttributedString(attributedString: originalString)
        let range = NSRange(location: 0, length: originalString.length)
        newString.addAttribute(.strikethroughStyle, value: 2, range: range)

        return newString
    }

}
