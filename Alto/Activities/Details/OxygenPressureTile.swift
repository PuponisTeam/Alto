//
//  OxygenPressureTile.swift
//  Alto
//
//  Created by Michele Coppola on 18/03/25.
//

import SwiftUI

struct OxygenPressureTile: View {
    @Environment(\.altitudeService) private var altitudeService
    
    var body: some View {
        Tile(.half) {
            Text("\(altitudeService.oxygenPressure.formatted()) hPa")
                .font(.system(size: 25, weight: .heavy, design: .default))
                .minimumScaleFactor(0.3)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding()
                .foregroundStyle(.white)
        } background: {
            Color.blue
                .noiseEffect()
        } label: {
            Label("Oxygen", systemImage: "wind")
                .foregroundStyle(.white)
                .font(.headline)
        }
    }
}

#Preview {
    OxygenPressureTile()
}
