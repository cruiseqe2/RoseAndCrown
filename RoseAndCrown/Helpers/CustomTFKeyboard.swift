//
//  CustomTFKeyboard.swift
//  CustomKeyboard
//
//  Created by Mark Oelbaum on 27/08/2024.
//

import SwiftUI

/// Custom TextField Keyboard TextField Modifier
extension TextField {
    @ViewBuilder
    func inputView<Content: View>(_ placeholder: String, @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .background {
                SetTFKeyboard(placeholder: placeholder, keyboardContent: content())
            }
    }
}

struct SetTFKeyboard<Content: View>: UIViewRepresentable {
    @Environment(ViewModel.self) var vm
    var placeholder: String
    var keyboardContent: Content

    @State private var hostingController: UIHostingController<Content>?
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            if let textFieldContainerView = uiView.superview?.superview {
                if let textField = textFieldContainerView.findTextField(placeholder) {
                    /// If the input is already set, then updating its content
                    if textField.inputView == nil {
                        /// Now with the help of UIHosting Controller converting SwiftUI View into UIKit View
                        hostingController = UIHostingController(rootView: keyboardContent)
                        hostingController?.view.frame = .init(origin: .zero, size: hostingController?.view.intrinsicContentSize ?? .zero)
                        /// Setting TF's Input View as our SwiftUI View
                        textField.inputView = hostingController?.view
                    } else {
                        /// Updating Hosting Content
                        hostingController?.rootView = keyboardContent
                    }
                } else {
                    print("Failed to find TF")
                }
            }
        }
    }
}

/// Extracting TextField from the subviews
fileprivate extension UIView {
    
    /// https://stackoverflow.com/questions/32151637/swift-get-all-subviews-of-a-specific-type-and-add-to-an-array
    func subviewsOfSelectedType<T:UIView>(_ WhatType:T.Type) -> [T] {
        var result = self.subviews.compactMap {$0 as? T}
        for sub in self.subviews {
            result.append(contentsOf: sub.subviewsOfSelectedType(WhatType))
        }
        return result
    }
    
    func findTextField(_ placeholder: String) -> UITextField? {
        let arr = self.subviewsOfSelectedType(UITextField.self)
        let theOne = arr.filter { $0.placeholder == placeholder }.first
        return theOne
    }
}
