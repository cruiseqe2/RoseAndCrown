//
//  BarItemsView.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 08/08/2024.
//

import SwiftUI

struct BarItemsView: View {
    
    @Environment(ViewModel.self) var vm
    
    var body: some View {
        
        List(vm.barItems) { barItem in
            Text(barItem.name)
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
    BarItemsView()
        .environment(ViewModel())
}
