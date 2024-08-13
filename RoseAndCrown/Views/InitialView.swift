import SwiftUI

struct InitialView: View {
    
    @Environment(ViewModel.self) var vm
    
    var body: some View {
        NavigationStack {
            TabView(selection: Bindable(vm).selectedTab) {
                TabItemsView()
                    .tabItem {
                        Label("Tab Items", systemImage: "sterlingsign.circle")
                    }
                    .tag(ViewModel.Tabs.tabItems)
                
                BarItemsView()
                    .tabItem {
                        Label("Bar Items", systemImage: "wineglass")
                    }
                    .tag(ViewModel.Tabs.barItems)
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .tag(ViewModel.Tabs.settings)
                
            }
            .navigationTitle(vm.selectedTab.title)
        }
        .ignoresSafeArea(.all)
//        .padding()
        
        
        
        
        
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
        .task {
            vm.loadItems()
        }
    }
    
}

#Preview {
    InitialView()
        .environment(ViewModel())
   
}

