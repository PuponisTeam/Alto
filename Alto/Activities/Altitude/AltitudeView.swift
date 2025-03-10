//
//  AltitudeView.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 10/03/25.
//

import SwiftUI

struct AltitudeView: View {
    @Environment(\.altitudeService) private var altitudeService
    
    var altitude: Int {
        Int(altitudeService.absoluteAltitude.rounded())
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: -80) {
            Text("\(altitude)")
                .contentTransition(.numericText(value: Double(altitude)))
                .font(.custom("AkiLines", size: 360))
                .minimumScaleFactor(0.3)
            
            Text("meters")
                .font(.system(size: 100).weight(.ultraLight))
                .padding(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .animation(.default, value: altitude)
        .foregroundStyle(.offBlack)
    }
}

#Preview {
    AltitudeView()
}
