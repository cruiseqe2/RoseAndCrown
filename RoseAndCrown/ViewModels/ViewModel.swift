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
    }
    
    let itemsURL = URL.documentsDirectory.appending(path: "barItems.json")
    
    var barItems: [BarItem] = []
    var selectedTab: Tabs = .barItems
    
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
