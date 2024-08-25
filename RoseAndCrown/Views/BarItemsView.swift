//
//  BarItemsView.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 08/08/2024.
//

import SwiftUI

struct BarItemsView: View {
    
    @Environment(ViewModel.self) var vm
    @State private var isAddSheetShowing = false
    
    @State private var selectedBarItem: BarItem?
    
    var body: some View {
        
        List {
            ForEach(vm.barItems.sorted()) { barItem in
                Text(barItem.name)
                    .swipeActions(allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            vm.removeBarItem(barItem)
                        } label: {
                            swipeIcon(label: "Delete", symbolName: "trash")
                        }
                        Button() {
                            selectedBarItem = barItem
                        } label: {
                            swipeIcon(label: "Edit", symbolName: "pencil")
                        }
                        .tint(.green)
                    }
            }
        }
        .sheet(isPresented: $isAddSheetShowing) {
            NewOrUpdateBarItemView()
                .presentationDetents([.medium])
                .interactiveDismissDisabled()
        }
        .sheet(item: $selectedBarItem, content: { barItem in
            NewOrUpdateBarItemView(barItem: barItem)
                .presentationDetents([.medium])
                .interactiveDismissDisabled()
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isAddSheetShowing.toggle()
                } label: {
                    Label("New Item", systemImage: "plus")
                }
            }
        }
    }
    
    private func swipeIcon(label: String, symbolName: String) -> some View {
        let w: CGFloat = 60
        let h = w
        let size = CGSize(width: w, height: h)
        let text = Text(LocalizedStringKey(label))
        let symbol = Image(systemName: symbolName)
        return Image(size: size, label: text) { ctx in
            let resolvedText = ctx.resolve(text)
            let textSize = resolvedText.measure(in: CGSize(width: w, height: h * 0.6))
            let resolvedSymbol = ctx.resolve(symbol)
            let symbolSize = resolvedSymbol.size
            let heightForSymbol: CGFloat = min(h * 0.35, (h * 0.9) - textSize.height)
            let widthForSymbol = (heightForSymbol / symbolSize.height) * symbolSize.width
            let xSymbol = (w - widthForSymbol) / 2
            let ySymbol = max(h * 0.05, heightForSymbol - (textSize.height * 0.6))
            let yText = ySymbol + heightForSymbol + max(0, ((h * 0.8) - heightForSymbol - textSize.height) / 2)
            let xText = (w - textSize.width) / 2
            ctx.draw(
                resolvedSymbol,
                in: CGRect(x: xSymbol, y: ySymbol, width: widthForSymbol, height: heightForSymbol)
            )
            ctx.draw(
                resolvedText,
                in: CGRect(x: xText, y: yText, width: textSize.width, height: textSize.height)
            )
        }
        .foregroundStyle(.white)
        .font(.body)
        .lineLimit(2)
        .lineSpacing(-2)
        .minimumScaleFactor(0.7)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    NavigationStack() {
        BarItemsView()
            .environment(ViewModel())
            .navigationTitle("Bar Items")
    }
}
