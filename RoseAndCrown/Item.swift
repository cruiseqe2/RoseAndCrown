//
//  Item.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 07/08/2024.
//

import Foundation

struct Item: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var price: Decimal
}
