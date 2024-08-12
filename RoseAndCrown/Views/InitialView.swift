import SwiftUI

struct InitialView: View {
    
    @Environment(ViewModel.self) var vm
    
    enum Tabs: String {
        case barItems
        case tabItems
        case settings
        
        var title: String {
            switch self {
            case .barItems:
                "Bar Items"
            case .tabItems:
                "Tab Items"
            case .settings:
                "Settings"
            }
        }
    }
    
    @State private var selectedTab: Tabs = .tabItems
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                TabItemsView()
                    .tabItem {
                        Label("Tab Items", systemImage: "sterlingsign.circle")
                    }
                    .tag(Tabs.tabItems)
                
                BarItemsView()
                    .tabItem {
                        Label("Bar Items", systemImage: "wineglass")
                    }
                    .tag(Tabs.barItems)
                
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                    .tag(Tabs.settings)
                
            }
            .navigationTitle(selectedTab.title)
        }
        .ignoresSafeArea()
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

