//
//  AltitudeView.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 10/03/25.
//

import SwiftUI

struct AltitudeView: View {
    @Binding var isCompact: Bool
    @Environment(\.altitudeService) private var altitudeService
    
    var layout: AnyLayout {
        isCompact
        ? AnyLayout(HStackLayout(alignment: .bottom))
        : AnyLayout(VStackLayout(alignment: .leading, spacing: -100))
    }
    
    var body: some View {
        VStack {
            altitudeText
                .padding(isCompact ? 20 : 0)
            
            if !isCompact {
                Spacer()
            }
        }
        .frame(maxHeight: isCompact ? 150 : .infinity)
        .background {
            RoundedRectangle(cornerRadius: 32)
                .fill(.customOrange)
                .ignoresSafeArea()
                .noiseEffect(opacity: 0.085)
        }
        .overlay(alignment: isCompact ? .topTrailing : .bottom) {
            DetailsButton(isCompact: $isCompact)
                .padding(isCompact ? 15 : 0)
        }
    }
    
    private var altitudeText: some View {
        layout {
            Text("\(altitudeService.absoluteAltitude.displayValue)")
                .contentTransition(.numericText(value: Double(altitudeService.absoluteAltitude.displayValue)))
                .font(.custom("AkiLines", size: isCompact ? 150 : 360))
                .minimumScaleFactor(0.3)
            
            Text(altitudeService.absoluteAltitude.formattedUnit(width: .wide))
                .font(.system(size: isCompact ? 80 : 100).weight(.ultraLight))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .animation(.default, value: altitudeService.absoluteAltitude)
        .foregroundStyle(.offBlack)
        
    }
}

#Preview {
    @Previewable @State var isCompact = false
    AltitudeView(isCompact: $isCompact)
}
