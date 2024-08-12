//
//  RoseAndCrownApp.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 07/08/2024.
//

import SwiftUI

@main
struct RoseAndCrownApp: App {
    
    @State private var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            InitialView()
                .environment(viewModel)
        }
    }
}
