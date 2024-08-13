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
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.mint.ignoresSafeArea()
                VStack {
                    Text("Add Bar Item View")
                }
                .padding(50)
            }
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
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}

#Preview {
    AddBarItemView()
        .environment(ViewModel())
}
