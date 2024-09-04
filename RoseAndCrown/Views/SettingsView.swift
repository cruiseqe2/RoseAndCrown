//
//  SettingsView.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 12/08/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(ViewModel.self) var vm
    
    var body: some View {
        @Bindable var vm = vm
        
        Form {
            Section(header: Text("Display Mode"),
                    footer: Text("System settings will override DarkLight mode and use the current device theme")) {
              
                DisplayModeControl()
                    .frame(maxWidth: .infinity)
                
                
//                Toggle(isOn: $vm.systemMode) {
//                    Text("Use system settings")
//                }
//                
//                Toggle(isOn: $vm.darkMode) {
//                    Text("Dark mode")
//                        .opacity(vm.systemMode ? 0.3 : 1)
//                }
//                .disabled(vm.systemMode)
                
            }
            
            
        }
        
        
//        Color.teal
            .navigationTitle(vm.selectedTab.title)
////        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    NavigationStack() {
        SettingsView()
            .environment(ViewModel())
            .navigationTitle("Settings View")
    }
}
