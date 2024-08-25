import SwiftUI

struct InitialView: View {
    
    @Environment(ViewModel.self) var vm
    @State private var isAlertShowing = false
    @State private var myError: AppError = AppError.null
    
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
        .task {
            do {
                try vm.loadItems()
            } catch {
                myError = AppError.decodingError
                isAlertShowing = true
            }
            vm.selectedTab = (vm.barItems.isEmpty ? .barItems : .tabItems)
        }
        .alert(isPresented: $isAlertShowing, error: myError) { error in
            // Buttons, if any, go here! OK is the default button.
        } message: { error in
            Text(error.failureReason)
        }
    }
}

#Preview {
    InitialView()
        .environment(ViewModel())
   
}

