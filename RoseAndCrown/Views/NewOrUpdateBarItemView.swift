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
    
    @State private var produceError = false
    @State private var mode: ViewModel.Mode = .new
    @State private var newItemName = ""
    @State private var newItemPriceString = ""
    @State private var showAlert = false
    private var saveDisabled: Bool {
        newItemName.isEmpty || newItemPriceString.isEmpty
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Toggle(isOn: $produceError) {
                    Text("Produce Error")
                }
                
                TextField("Enter Bar Item Name", text: $newItemName)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled()
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
//                        print(newItemPriceString, newItemPriceString.convertedToInt())
//                        print(Double(newItemPriceString) ?? 1.0)
//                        print((Double(newItemPriceString) ?? 1.0) * 100.00)
//                        print(((Double(newItemPriceString) ?? 1.0) * 100.00).rounded())
                        let uuid = mode == .updating ? barItem?.id : nil
                        if vm.isBarItemEntryValid(uuid: uuid, name: newItemName, priceInPence: newItemPriceString.convertedToInt()) {
                            if mode == .new {
                                vm.generateNewBarItem(BarItem(name: newItemName, priceInPence: newItemPriceString.convertedToInt()))
                            } else {
//                                vm.generateNewBarItem(<#T##item: BarItem##BarItem#>)
                            }
                            dismiss()
                        } else {
                            showAlert.toggle()
                        }
                    } label: {
                        Text(mode == .updating ? "Update" : "Save")
                    }
                    .disabled(saveDisabled)
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
            UITextField.appearance().clearButtonMode = .whileEditing
            if let barItem {
                newItemName = barItem.name
                newItemPriceString = barItem.priceInPence.convertedToString()
                mode = .updating
            } else {
                newItemName = ""
                newItemPriceString = ""
                mode = .new
            }
        }
        .alert(
            "‼️ Oooops ‼️",
            isPresented: $showAlert,
            presenting: vm.alertText,
            actions: { _ in },
            message: { alertText in
                Text(alertText)
            }
        )
    }
}

//#Preview {
//    AddBarItemView()
//        .environment(ViewModel())
//}
