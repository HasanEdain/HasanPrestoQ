//
//  ManagersSpecials.swift
//  HasanPrestoQ
//
//  Created by Hasan D Edain on 3/19/19.
//  Copyright © 2019 NPC Unlimited. All rights reserved.
//

import Foundation

struct ManagersSpecials:Codable {
    let canvasUnit: Int
    let managerSpecials: [ManagerSpecial]

    init(canvasUnit: Int, managersSpecials: [ManagerSpecial]) {
        self.canvasUnit = canvasUnit
        self.managerSpecials = managersSpecials
    }

    func count() -> Int {
        return managerSpecials.count
    }

    func specialAtIndex(index: Int) -> ManagerSpecial {
        guard index >= 0 else {
            assert(false, "Index must be greater than or equal to zero")
        }

        guard index < count() else {
            assert(false, "Index must be less than the count of specials")
        }

        return managerSpecials[index]
    }

}
