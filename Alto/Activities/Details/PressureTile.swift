//
//  PressureTile.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 14/03/25.
//

import SwiftUI

struct PressureTile: View {
    @Environment(\.altitudeService) private var altitudeService
    
    var body: some View {
        Tile(.half) {
            Text(
                altitudeService.pressure.formatted(
                    .measurement(
                        width: .abbreviated,
                        usage: .barometric
                    )
                )
            )
            .font(.system(size: 25, weight: .heavy, design: .default))
            .minimumScaleFactor(0.3)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .padding()
            .foregroundStyle(.white)
        } background: {
            Color.indigo
                .noiseEffect()
        } label: {
            Label("Pressure", systemImage: "barometer")
                .foregroundStyle(.white)
                .font(.headline)
        }

    }
}

#Preview {
    PressureTile()
}
