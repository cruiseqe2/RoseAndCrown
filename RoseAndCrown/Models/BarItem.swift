//
//  BarItem.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 07/08/2024.
//

import Foundation

struct BarItem: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var name: String
    var priceInPence: Int
}

extension BarItem: Comparable {
    static func < (lhs: BarItem, rhs: BarItem) -> Bool {
        return lhs.name < rhs.name
    }
}
