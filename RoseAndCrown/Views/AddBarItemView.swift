//
//  AddBarItemView.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 13/08/2024.
//

import SwiftUI

struct AddBarItemView: View {
    
    @Environment(ViewModel.self) var vm
    @Environment(\.dismiss) private var dismiss
    
    @State private var isOn = false
    @State private var newItem = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Toggle(isOn: $isOn) {
                    Text("Toggle")
                }
                TextField("Enter Bar Item Name", text: $newItem)
                    .textFieldStyle(.roundedBorder)
            }
            .navigationTitle("Add new Bar Item")
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
                        validateAndSave()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
        
    }
    func validateAndSave() {
        let newBarItem = BarItem(name: newItem, price: 0.99)
        vm.generateNewBarItem(newBarItem)
    }
}

//#Preview {
//    AddBarItemView()
//        .environment(ViewModel())
//}
