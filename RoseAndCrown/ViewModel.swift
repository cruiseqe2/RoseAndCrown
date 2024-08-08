//
//  ViewModel.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 07/08/2024.
//

import Foundation

@Observable
class ViewModel {
    
    let defaults = UserDefaults.standard
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let itemsURL = URL.documentsDirectory.appending(path: "items.json")
    
    var items: [Item] = []
    
    func loadItems() {
        if FileManager().fileExists(atPath: itemsURL.path) {
            do {
                let jsonData = try Data(contentsOf: itemsURL)
                items = try decoder.decode([Item].self, from: jsonData)
            } catch {
                items = []
                print(error.localizedDescription)
            }
        }
        
        if items.isEmpty {
            items = [
                Item(name: "Crisps", price: 1.20),
                Item(name: "Diet Coke", price: 4.05)
            ]
            saveItems()
        }
    }
    
    func saveItems() {
        do {
            let itemsData = try encoder.encode(items)
            try itemsData.write(to: itemsURL, options: [.atomic, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addOne() {
        let newItem = Item(name: "Chips", price: 3.25)
        items.append(newItem)
        saveItems()
    }
    
}
