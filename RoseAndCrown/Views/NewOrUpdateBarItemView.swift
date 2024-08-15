//
//  EditBarItemView.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 14/08/2024.
//

import SwiftUI

struct NewOrUpdateBarItemView: View {
    
    enum FocusedField {
        case decimal
        case integer
    }
    @FocusState private var focusedField: FocusedField?
    
    @Environment(ViewModel.self) var vm
    @Environment(\.dismiss) private var dismiss
    
    var barItem: BarItem?
    
    @State private var isOn = false
    @State private var mode: ViewModel.Mode = .new
    @State private var newItemName = ""
    @State private var newItemPriceString = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Toggle(isOn: $isOn) {
                    Text("Toggle")
                }
                
                TextField("Enter Bar Item Name", text: $newItemName)
                    .textFieldStyle(.roundedBorder)
                TextField("Enter Bar Item Price", text: $newItemPriceString)
                    .focused($focusedField, equals: .decimal)
                    .decimalsOnly($newItemPriceString, decimalPlaces: 2)
                    .textFieldStyle(.roundedBorder)
                
            }
            .navigationTitle(mode == .updating ? "Edit Bar Item" : "New Bar Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
//                        validateAndSave()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
                if focusedField != nil {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button {
                            focusedField = nil
                        } label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                        }
                    }
                }
                
            }
        }
        .onAppear {
            if let barItem {
                newItemName = barItem.name
//                newItemPriceString = String(barItem.price)
//                newItemPrice = 5.60
                mode = .updating
            } else {
                newItemName = ""
                newItemPriceString = ""
                mode = .new
            }
        }
    }
    
    //    func validateAndSave() {
    //        let newBarItem = BarItem(name: newItem, price: 0.99)
    //        vm.generateNewBarItem(newBarItem)
    //    }
}

//#Preview {
//    AddBarItemView()
//        .environment(ViewModel())
//}
