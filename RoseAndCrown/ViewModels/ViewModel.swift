//
//  ViewModel.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 07/08/2024.
//

import Foundation

@Observable
class ViewModel {
    
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
    
    enum Mode: String {
        case updating
        case new
    }
        
    var selectedTab: Tabs = .barItems
    
    //================================================================
    // Bar Items
    //================================================================
    
    let itemsURL = URL.documentsDirectory.appending(path: "barItems.json")
    
    var barItems: [BarItem] = []
    
    func loadItems() {
        if FileManager().fileExists(atPath: itemsURL.path) {
            do {
                let jsonData = try Data(contentsOf: itemsURL)
                barItems = try JSONDecoder().decode([BarItem].self, from: jsonData)
            } catch {
                barItems = []
                print(error.localizedDescription)
            }
        }
        
        if barItems.isEmpty {
            barItems = [
                BarItem(name: "Crisps", price: 1.20),
                BarItem(name: "Diet Coke", price: 4.05)
            ]
            saveItems()
        }
    }
    
    func removeBarItem(_ item: BarItem) {
        var indexes = IndexSet()
        if let index = barItems.firstIndex(of: item) {
            indexes.insert(index)
        }
        barItems.remove(atOffsets: indexes)
        saveItems()
    }
    
    func generateNewBarItem(_ item: BarItem) {
        barItems.append(item)
        saveItems()
    }
    
    func saveItems() {
        do {
            let itemsData = try JSONEncoder().encode(barItems)
            try itemsData.write(to: itemsURL, options: [.atomic, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addOne() {
        let newItem = BarItem(name: "Chips", price: 3.25)
        barItems.append(newItem)
        saveItems()
    }
    
}
