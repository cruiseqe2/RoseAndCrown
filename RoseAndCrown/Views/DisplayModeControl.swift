//
//  DisplayModeControl.swift
//  RoseAndCrown
//
//  Created by Mark Oelbaum on 04/09/2024.
//

import SwiftUI

struct DisplayModeControl: View {
    
    @Environment(ViewModel.self) var vm
    
    @State private var selectedItem: DisplayMode = .light
    @Namespace private var animation
    
    var body: some View {
        //        @Bindable var vm = vm
        HStack(spacing: 0) {
            ForEach(DisplayMode.allCases, id: \.rawValue) { displayMode in
                Text(displayMode.rawValue)
                    .padding(.vertical, 10)
                    .frame(width: 100)
                    .foregroundStyle(selectedItem == displayMode ? .white : .primary)
                    .bold(selectedItem == displayMode)
                    .background(alignment: .center) {
                        ZStack {
                            if selectedItem == displayMode {
                                Capsule()
                                    .foregroundStyle(Color.accentColor)
                                    .matchedGeometryEffect(id: "what", in: animation)
                            }
                        }  /* End of ZStack */
                        .animation(.bouncy, value: selectedItem)
                    }  /* End of .background */
                    .contentShape(.rect)
                    .onTapGesture {
                        selectedItem = displayMode
                        vm.displayMode = displayMode
                    }  /* End of Tap Gesture */
            }  /* End of ForEach */
        }  /* End of HStack */
        .padding(5)
        .background(.primary.opacity(0.08), in: Capsule())
        .onAppear {
            selectedItem = vm.displayMode
        }
    }  /* End of body View */
}  /* End of Struct DisplayModeControl View */


#Preview {
    DisplayModeControl()
        .environment(ViewModel())
}
