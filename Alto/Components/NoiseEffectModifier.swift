//
//  NoiseEffectModifier.swift
//  Test
//
//  Created by Alessio Garzia Marotta Brusco on 11/10/24.
//

import SwiftUI

struct NoiseEffectModifier: ViewModifier {
    let opacity: Double
    
    func body(content: Content) -> some View {
        content
            .overlay {
                content
                    .colorEffect(ShaderLibrary.noise())
                    .opacity(opacity)
            }
    }
}

extension View {
    /// Applies a noise effect to this view.
    /// - Parameter opacity: a value between 0 (noise layer fully transparent) and 1 ( noise layer fully opaque).
    ///
    ///  This modifier overlays this view to itself applying the _noise_ shader.
    ///  The opacity parameter controls how opaque this overlay layer is.
    func noiseEffect(opacity: Double = 0.08) -> some View {
        self
            .modifier(NoiseEffectModifier(opacity: opacity))
    }
}

#Preview {
    Rectangle()
        .fill(.red)
        .modifier(NoiseEffectModifier(opacity: 0.2))
}
