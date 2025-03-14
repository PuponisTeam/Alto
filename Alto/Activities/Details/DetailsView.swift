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
    
    var body: some View {
        Grid(
            horizontalSpacing: Self.spacing,
            verticalSpacing: Self.spacing
        ) {
            GridRow {
                PressureTile()
                PressureTile()
            }
            
            GridRow {
                PressureTile()
                PressureTile()
            }
            
            GridRow {
                PressureTile()
                PressureTile()
            }
        }
        .transition(.move(edge: .bottom).combined(with: .scale).combined(with: .opacity))
    }
}

#Preview {
    DetailsView()
}
