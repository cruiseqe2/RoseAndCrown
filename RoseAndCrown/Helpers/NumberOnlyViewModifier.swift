//
//  NumberOnlyViewModifier.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 14/08/2024.
//

import SwiftUI
import Combine

struct NumberOnlyViewModifier: ViewModifier {
    
    @Binding var text: String
    var includeDecimal: Bool
    var decimalPlaces: Int
    
    func body(content: Content) -> some View {
        content
            .keyboardType(includeDecimal ? .decimalPad : .numberPad)
            .onReceive(Just(text)) { newValue in
                var numbers = "0123456789"
                let decimalSeparator: String = Locale.current.decimalSeparator ?? "."
                if includeDecimal {
                    numbers += decimalSeparator
                }
                let array = newValue.components(separatedBy: decimalSeparator)
                if array.count > 2 ||
                    (array.count == 2 && array[1].count > decimalPlaces)
                {
                    let filtered = newValue
                    self.text = String(filtered.dropLast())
                } else {
                    let filtered = newValue.filter { numbers.contains($0) }
                    if filtered != newValue {
                        self.text = filtered
                    }
                }
            }
        }
}

extension View {
    func decimalsOnly(_ text: Binding<String>, decimalPlaces: Int = 2) -> some View {
        self.modifier(NumberOnlyViewModifier(text: text, includeDecimal: true, decimalPlaces: decimalPlaces))
    }
    func numbersOnly(_ text: Binding<String>) -> some View {
        self.modifier(NumberOnlyViewModifier(text: text, includeDecimal: false, decimalPlaces: 0))
    }
}
