//
//  ManagerSpecialTests.swift
//  HasanPrestoQTests
//
//  Created by Hasan D Edain on 3/22/19.
//  Copyright © 2019 NPC Unlimited. All rights reserved.
//

import XCTest
@testable import HasanPrestoQ

class ManagerSpecialTests: XCTestCase {

    var managersSpecialOne: ManagerSpecial?

    let imageURLString = "https://google.com"
    let width = 8
    let height = 16
    let displayName = "displayName"
    let originalPrice = "2.99"
    let price = "1.00"

    override func setUp() {
        managersSpecialOne = ManagerSpecial(imageUrl: imageURLString, width: width, height: height, display_name: displayName, original_price: originalPrice, price: price)
    }

    func testUrlForImage() {
        let url = managersSpecialOne?.urlForImage()
        XCTAssertNotNil(url)
        XCTAssert(url?.absoluteString == imageURLString)
        XCTAssert(url?.host == "google.com")

        let firstBadUrlString = "ThisIsNotAURL"
        let firstManagersSpecial = ManagerSpecial(imageUrl: firstBadUrlString, width: width, height: height, display_name: displayName, original_price: originalPrice, price: price)
        let firstBadUrl = firstManagersSpecial.urlForImage()
        XCTAssertNil(firstBadUrl)

        let secondBadUrlString = "http://google.com"
        let secondManagersSpecial = ManagerSpecial(imageUrl: secondBadUrlString, width: width, height: height, display_name: displayName, original_price: originalPrice, price: price)
        let secondBadUrl = secondManagersSpecial.urlForImage()
        XCTAssertNil(secondBadUrl)

        let thirdBadUrlString = ""
        let thirdManagersSpecial = ManagerSpecial(imageUrl: thirdBadUrlString, width: width, height: height, display_name: displayName, original_price: originalPrice, price: price)
        let thirdBadUrl = thirdManagersSpecial.urlForImage()
        XCTAssertNil(thirdBadUrl)

    }

    //TODO: More thorough testing of this method: other values, high values, negative values, non numeric values
    func testDecimalPrice() {
        let decimal = managersSpecialOne?.decimalPrice()
        XCTAssert(decimal == 1.00)

        let firstManagersSpecial = ManagerSpecial(imageUrl: imageURLString, width: width, height: height, display_name: displayName, original_price: originalPrice, price: "foo")
        XCTAssert(firstManagersSpecial.decimalPrice() == .nan)
    }

     //TODO: More thorough testing of this method: other values, high values, negative values, non numeric values
    func testDecimalOriginalPrice() {
        let decimal = managersSpecialOne?.decimalOriginalPrice()
        XCTAssert(decimal == 2.99)

        let firstManagersSpecial = ManagerSpecial(imageUrl: imageURLString, width: width, height: height, display_name: displayName, original_price: "bar", price: price)
        XCTAssert(firstManagersSpecial.decimalOriginalPrice() == .nan)
    }

    //TODO: Test where I ensure the locale is set a particular way, and I get the correct currency symbol
    // As best as I can determine this requires a seperate test target per localization, more than I am ready
    // for in example code.
    func testAttributedString() {
        let attributedString = ManagerSpecial.attributedString(numberString: originalPrice)
        XCTAssertNotNil(attributedString)
        let string = attributedString.string
        let compareString = "$\(originalPrice)"
        XCTAssert(string == compareString)
    }

    func testStrikethroughAttributedString() {
        let strikethourhString = ManagerSpecial.strikethroughAttributedString(numberString: originalPrice)
        XCTAssertNotNil(strikethourhString)
        let string = strikethourhString.string
        let compareString = "$\(originalPrice)"
        XCTAssert(compareString == string)
        let attributes = strikethourhString.attributes(at: 0, effectiveRange: nil)
        let firstAttribute = attributes.first
        let firstKey = firstAttribute?.key

        XCTAssertNotNil(firstKey?.rawValue == "NSStrikethrough")
    }

    // The business value of this test is very low. probabbly ok to omit, just including for completeness
    func testInit() {
        let imageURLString = "https://google.com"
        let width = 8
        let height = 16
        let displayName = "displayName"
        let originalPrice = "2.99"
        let price = "1.00"
        let managerSpecial = ManagerSpecial(imageUrl: imageURLString, width: width, height: height, display_name: displayName, original_price: originalPrice, price: price)
        XCTAssertNotNil(managerSpecial.urlForImage())
        XCTAssert(managerSpecial.urlForImage()?.absoluteString == imageURLString)
        XCTAssert(managerSpecial.width == width)
        XCTAssert(managerSpecial.height == height)
        XCTAssert(managerSpecial.display_name == displayName)
        XCTAssert(managerSpecial.original_price == originalPrice)
        XCTAssert(managerSpecial.price == price)
    }

}
