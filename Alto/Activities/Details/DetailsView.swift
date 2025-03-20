//
//  DetailsView.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 12/03/25.
//

import SwiftUI

// Pressione, Modello 3D, Ossigeno, UV.

struct DetailsView: View {
    static let spacing = 20.0
    @Binding var showModel3DView: Bool
    @Environment(\.altitudeService) private var altitudeService
    
    var body: some View {
        Grid(
            horizontalSpacing: Self.spacing,
            verticalSpacing: Self.spacing
        ) {
            GridRow {
                PressureTile()
                OxygenPressureTile()
            }
            
            GridRow {
                Model3DTile(altitudeService: altitudeService)
                
                Tile(.half) {
                    Text("5")
                    .font(.system(size: 25, weight: .heavy, design: .default))
                    .minimumScaleFactor(0.3)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding()
                    .foregroundStyle(.white)
                } background: {
                    Color.red
                        .noiseEffect()
                } label: {
                    Label("UV Index", systemImage: "sun.max.fill")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
            }
        }
        .transition(.move(edge: .bottom).combined(with: .scale).combined(with: .opacity))
    }
}

#Preview {
    @Previewable @State var showModel3DView: Bool = false
    DetailsView(showModel3DView: $showModel3DView)
}
