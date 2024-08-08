//
//  ContentView.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 07/08/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var vm = ViewModel()
    
    
    
    
    var body: some View {
        VStack {
            Button("Add One") {
                vm.addOne()
            }
            Button("Save Items") {
                vm.saveItems()
            }
            List(vm.items) { item in
                Text(item.name)
            }
        }
        .task {
            vm.loadItems()
        }
    }
        
    
    
    
    
    
    
}

#Preview {
    ContentView()
}

