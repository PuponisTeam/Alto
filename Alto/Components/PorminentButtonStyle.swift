//
//  PorminentButtonStyle.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 12/03/25.
//

import SwiftUI

struct MaterialProminentButtonStyle: ButtonStyle {
    var padding: Double
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(padding)
            .background(.thinMaterial, in: .buttonBorder)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

extension ButtonStyle where Self == MaterialProminentButtonStyle {
    static var materialProminent: MaterialProminentButtonStyle {
        MaterialProminentButtonStyle(padding: 12)
    }
    
    static func materialProminent(padding: Double) -> MaterialProminentButtonStyle {
        MaterialProminentButtonStyle(padding: padding)
    }
}

#Preview {
    Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
    }
    .buttonStyle(MaterialProminentButtonStyle(padding: 12))
}
