//
//  TabItemsView.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 08/08/2024.
//

import SwiftUI

struct TabItemsView: View {
    
    @Environment(ViewModel.self) var vm
    
    var body: some View {
        Color.green
//        Text("Tab Items View")
    }
}

#Preview {
    TabItemsView()
        .environment(ViewModel())
}
