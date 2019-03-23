//
//  StringUtility.swift
//  HasanPrestoQ
//
//  Created by Hasan D Edain on 3/23/19.
//  Copyright © 2019 NPC Unlimited. All rights reserved.
//

import Foundation

struct StringUtility {

    /**
     Takes a string with a decimal value and returns a locale sensitive currency formate string.
     - parameter numberString: the input string must contain a decimal format, or this will return an empty string.
     - returns: an attributed string that has a locale sensitive currency symbol. Or an empty string if input is invalid
     */
    static func attributedPriceString(numberString: String) -> NSAttributedString {
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

    /**
     Takes a string with a decimal value and returns a locale sensitive currency formate and struckthrough string.
     - parameter numberString: the input string must contain a decimal format, or this will return an empty string.
     - returns: an attributed string that has a locale sensitive currency symbol and is strickthrough. Or an empty string if input is invalid
     */
    static func strikethroughAttributedPriceString(numberString:String) -> NSAttributedString {
        let originalString = attributedPriceString(numberString: numberString)
        let newString = NSMutableAttributedString(attributedString: originalString)
        let range = NSRange(location: 0, length: originalString.length)
        newString.addAttribute(.strikethroughStyle, value: 2, range: range)

        return newString
    }

}
