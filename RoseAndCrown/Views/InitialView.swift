import SwiftUI

struct InitialView: View {
    
    @Environment(ViewModel.self) var vm
    @State private var isAlertShowing = false
    @State private var myError: AppError = AppError.null
    
    var body: some View {
        @Bindable var vm = vm
        TabView(selection: $vm.selectedTab) {
//        TabView(selection: Bindable(vm).selectedTab) {
            
            NavigationStack {
                TabItemsView()
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                
                            } label: {
                                Label("New Item", systemImage: "plus")
                            }
                        }
                    }
            }
            .tabItem {
                Label("Tab Items", systemImage: "sterlingsign.circle")
            }
            .tag(Tabs.tabItems)
            
            NavigationStack {
                BarItemsView()
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                vm.isBarItemsNewOrUpdateSheetShowing.toggle()
                            } label: {
                                Label("New Item", systemImage: "plus")
                            }
                        }
                    }
            }
            .tabItem {
                Label("Bar Items", systemImage: "wineglass")
            }
            .tag(Tabs.barItems)
            
            NavigationStack {
                SettingsView()
                    .toolbar {}
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
            .tag(Tabs.settings)
            
        }
        .ignoresSafeArea(.all)
        .task {
#if DEBUG
            UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
#endif
            do {
                try vm.loadItems()
            } catch {
                myError = AppError.decodingError
                isAlertShowing = true
            }
            vm.selectedTab = (vm.barItems.isEmpty ? .barItems : .tabItems)
        }
        //        .alert(isPresented: $isAlertShowing, error: myError) { error in
        //            // Buttons, if any, go here! OK is the default button.
        //        } message: { error in
        //            Text(error.failureReason)
        //        }
    }
}

#Preview {
    InitialView()
        .environment(ViewModel())
    
}

