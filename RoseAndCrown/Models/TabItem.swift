//
//  TabItem.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 08/08/2024.
//

import Foundation

struct TabItem: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var dateDate: Date
    var number: Int
}

