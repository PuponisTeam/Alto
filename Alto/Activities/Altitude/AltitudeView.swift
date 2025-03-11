//
//  AltitudeView.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 10/03/25.
//

import SwiftUI

struct AltitudeView: View {
    @Environment(\.altitudeService) private var altitudeService
    
    var body: some View {
        VStack(alignment: .leading, spacing: -50) {
            Text("\(altitudeService.absoluteAltitude.displayValue)")
                .contentTransition(.numericText(value: Double(altitudeService.absoluteAltitude.displayValue)))
                .font(.custom("AkiLines", size: 360))
                .minimumScaleFactor(0.3)
            
            Text(altitudeService.absoluteAltitude.formattedUnit(width: .wide))
                .font(.system(size: 100).weight(.ultraLight))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .animation(.default, value: altitudeService.absoluteAltitude)
        .foregroundStyle(.offBlack)
    }
}

#Preview {
    AltitudeView()
}
