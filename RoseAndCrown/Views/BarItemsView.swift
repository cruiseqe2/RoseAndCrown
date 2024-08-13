//
//  BarItemsView.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 08/08/2024.
//

import SwiftUI

struct BarItemsView: View {
    
    @Environment(ViewModel.self) var vm
    @State private var isAddSheetShowing = false
    
    var body: some View {
        
        List {
            ForEach(vm.barItems.sorted()) { barItem in
                Text(barItem.name)
                    .swipeActions {
                        Button(role: .destructive) {
                            vm.removeBarItem(barItem)
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
            }
        }
        .sheet(isPresented: $isAddSheetShowing) {
            AddBarItemView()
                .presentationDetents([.height(200)])
                .interactiveDismissDisabled()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isAddSheetShowing.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        
        
//        Color.red
//        VStack {
//            Button("Add One") {
//                vm.addOne()
//            }
//            Button("Save Items") {
//                vm.saveItems()
//            }
//            List(vm.barItems) { barItem in
//                Text(barItem.name)
//            }
//        }
       
    }

}

#Preview {
    NavigationStack() {
        BarItemsView()
            .environment(ViewModel())
            .navigationTitle("Bar Items")
    }
}
