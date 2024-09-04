//
//  ViewModel.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 07/08/2024.
//

import Foundation
import SwiftUI

@Observable
class ViewModel {
    
    var displayMode: DisplayMode = .system
    var darkMode: Bool = false
    var systemMode: Bool = false
        
    
    
    

//    var systemAppError: SystemErrorType? = nil
    var alertText = ""
    
    var selectedTab: Tabs = .settings
    
    //================================================================
    // Bar Items
    //================================================================
    
    let itemsURL = URL.documentsDirectory.appending(path: "barItems.json")
    
    var barItems: [BarItem] = []
    var isBarItemsNewOrUpdateSheetShowing = false
    
    var BIPlacerholderDescription = "Item Name"
    var BIPlaceholderPrice = "Item Price"
    
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
        //print(barItems)
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
        
    }
    
    //================================================================
    // Custom Keyboard Stuff
    //================================================================
   
    var fieldInFocus: FieldInFocus?
        
    /// Keyboard Button View
    func KeyboardButtonView(_ value: KeyboardButtonType, color: Color = .white, onTap: @escaping () -> ()) -> some View {
        Button(action: onTap) {
            ZStack {
                switch value {
                case .text(let string):
                    Text(string)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                case .image(let image):
                    Image(systemName: image)
                        .font(color == .white ? .title2 : .title)
                        .fontWeight(.semibold)
                        .foregroundStyle(color)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .contentShape(Rectangle())
        }
    }
    
}
