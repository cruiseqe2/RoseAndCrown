//
//  Tabs.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 02/09/2024.
//

enum Tabs: String {
    case barItems
    case tabItems
    case settings
    
    var title: String {
        switch self {
        case .barItems:
            "Bar Items"
        case .tabItems:
            "Tab Items"
        case .settings:
            "Settings"
        }
    }
}
