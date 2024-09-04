//
//  BarItemPriceView.swift
//  NumericKeypadTest
//
//  Created by Mark Oelbaum on 30/08/2024.
//

import SwiftUI

struct BarItemPriceView: View {
    
    @Environment(ViewModel.self) var vm
    @Binding var field: String
    @FocusState var fieldInFocus: FieldInFocus?
    
    var body: some View {
        @Bindable var vm = vm
        TextField(vm.BIPlaceholderPrice, text: $field)
            .inputView(vm.BIPlaceholderPrice) {
                CustomNumericKeypad(showDecimal: true)
            }
//            .textFieldStyle(.roundedBorder)
            .focused($fieldInFocus, equals: .amount)
            .syncFocusStates(focusState: $fieldInFocus, with: $vm.fieldInFocus)
            .decimalsOnly($field, decimalPlaces: 2)
//            .foregroundStyle(.red)
        
//            .environment(\.colorScheme, .light)
    }
    
    /// Custom Keyboard
    /// https://www.youtube.com/watch?v=jNpdpO32Pjs&t=616s
    @ViewBuilder
    func CustomNumericKeypad(showDecimal: Bool = false) -> some View {
        LazyVGrid(
            columns: Array(repeating: .init(.flexible(), spacing: 10),
                           count: 3), spacing: 10)
        {
            ForEach(1...9, id: \.self) { index in
                vm.KeyboardButtonView(.text("\(index)")) {
                    /// Adding Text
                    field.append("\(index)")
                }
            }
            /// Other Buttons
            vm.KeyboardButtonView(.image("xmark.circle"), color: .red) {
                field = ""
            }
            vm.KeyboardButtonView(.text("0")) {
                field.append("0")
            }
            vm.KeyboardButtonView(.image("delete.backward"), color: .indigo) {
                /// Removing Text One by One
                if !field.isEmpty {
                    field.removeLast()
                }
            }
            if showDecimal {
                vm.KeyboardButtonView(.text(".")) {
                    field.append(".")
                }
            } else {
                vm.KeyboardButtonView(.text("")) {}
            }
            vm.KeyboardButtonView(.text("00")) {
                field.append("00")
            }
            
            vm.KeyboardButtonView(.image("checkmark.circle.fill"), color: .green) {
                /// Closing Keyboard
                fieldInFocus = nil
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .background {
            Rectangle()
                .fill(Color("BG").gradient)
                .ignoresSafeArea()
        }
    }
    
}
