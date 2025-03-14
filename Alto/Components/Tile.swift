//
//  Tile.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 14/03/25.
//

import SwiftUI

struct Tile<Background: View, Content: View, Label: View>: View {
    enum Width {
        case full
        case half
        
        @MainActor var value: Double {
            switch self {
            case .full: 350
            case .half: (350 / 2) - DetailsView.spacing
            }
        }
    }
    
    let width: Width
    let background: Background
    let content: Content
    let label: Label
    
    init(
        _ width: Width,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder background: @escaping () -> Background,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.width = width
        self.background = background()
        self.content = content()
        self.label = label()
    }
    
    var body: some View {
        content
            .frame(width: width.value, height: Width.half.value)
            .overlay(alignment: .topLeading) {
                label
                    .padding()
            }
            .background {
                background
                    .clipShape(.rect(cornerRadius: 32))
            }
    }
}

#Preview {
    Tile(.half) {
        Text("9 kPa")
            .foregroundStyle(.white)
            .font(.largeTitle)
    } background: {
        Color(.customOrange)
            .noiseEffect()
    } label: {
        Label("Pressure", systemImage: "barometer")
            .foregroundStyle(.white)
            .bold()
    }
}
