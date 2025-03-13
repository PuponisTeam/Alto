//
//  PressableProminentButtonStyle.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 13/03/25.
//

import SwiftUI

struct PressableProminentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .padding()
            .background(.offBlack, in: .buttonBorder)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            
    }
}

extension ButtonStyle where Self == PressableProminentButtonStyle {
    static var pressable: PressableProminentButtonStyle {
        PressableProminentButtonStyle()
    }
}

#Preview {
    Button(action: { print("Pressed") }) {
        Label("Press Me", systemImage: "star")
    }
    .buttonStyle(PressableProminentButtonStyle())
}
