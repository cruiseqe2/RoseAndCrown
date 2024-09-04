//
//  Extensions.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 15/08/2024.
//

import Foundation
import SwiftUI

extension Int {
    func asString() -> String {
        String(format: "%.2f", Double(self) / 100.00)
    }
}

extension String {
    func asInt() -> Int {
        Int(((Double(self) ?? 0.0) * 100.00).rounded())
    }
}


extension View {
    
    /// https://gist.github.com/paescebu/f5ab50615b52f52f34bf2eff6185b54a
    func syncFocusStates<Value: Equatable>(focusState: FocusState<Value>.Binding, with: Binding<Value>) -> some View {
        self
            .onChange(of: with.wrappedValue) { _, newValue in
                focusState.wrappedValue = newValue
            }
            .onChange(of: focusState.wrappedValue) { _, newValue in
                with.wrappedValue = newValue
            }
    }
}
