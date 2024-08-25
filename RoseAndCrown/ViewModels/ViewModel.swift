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

//    var systemAppError: SystemErrorType? = nil
    var alertText = ""
    
    var selectedTab: Tabs = .barItems
    
    //================================================================
    // Bar Items
    //================================================================
    
    let itemsURL = URL.documentsDirectory.appending(path: "barItems.json")
    
    var barItems: [BarItem] = []
    
    func loadItems() throws {
//        if 2 == 2 { throw AppError.decodingError}
        if FileManager().fileExists(atPath: itemsURL.path) {
            do {
                let jsonData = try Data(contentsOf: itemsURL)
                barItems = try JSONDecoder().decode([BarItem].self, from: jsonData)
            } catch {
                barItems = []
                //systemAppError = SystemErrorType(error: .decodingError)
                throw AppError.decodingError
                //print(error.localizedDescription)
            }
        }
        
//        if barItems.isEmpty {
//            barItems = [
//                BarItem(name: "Crisps", priceInPence: 120),
//                BarItem(name: "Diet Coke", priceInPence: 405)
//            ]
//            saveItems()
//        }
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
//        if 2 == 2 { throw AppError.encodingError }
        do {
            let itemsData = try JSONEncoder().encode(barItems)
            try itemsData.write(to: itemsURL, options: [.atomic, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }
    
//    func addOne() {
//        let newItem = BarItem(name: "Chips", priceInPence: 325)
//        barItems.append(newItem)
//        saveItems()
//    }
    
    func isBarItemEntryValid(uuid: UUID?, name: String, priceInPence: Int) -> Bool {
        
        if uuid == nil { // New Bar Item
            let currentSet = Set(barItems.map { $0.name })
            if currentSet.contains(name) {
                alertText = "The Bar Item name must be unique."
                return false
            } else {
                return true
            }
        } else { // Amending a Bar Item
            let selectedItem = barItems.first { $0.id == uuid }
            if name == selectedItem!.name && priceInPence == selectedItem!.priceInPence {
                alertText = "You are having a laugh! You haven't changed a thing! Use the Cancel button."
                return false
            }
            var currentSet = Set<String>()
            for barItem in barItems {
                if barItem.id != uuid {
                    currentSet.insert(barItem.name)
                }
            }
            if currentSet.contains(name) {
                alertText = "You have not changed the Bar Item Name."
                return false
            } else {
                return true
            }
            
            
            
            
        }
        
        
        
        
        
        
        
//        return true
    }
    
}
