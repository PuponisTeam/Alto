//
//  AltitudeView.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 10/03/25.
//

import SwiftUI

// TODO: Add sensoryFeedback

struct AltitudeView: View {
    let altitudeService: AltitudeService
    
    @Binding var isCompact: Bool
    @State private var altitude: Int
    
    init(service altitudeService: AltitudeService, isCompact: Binding<Bool>) {
        self.altitudeService = altitudeService
        
        _isCompact = isCompact
        altitude = altitudeService.absoluteAltitude.displayValue
    }
    
    var layout: AnyLayout {
        isCompact
        ? AnyLayout(HStackLayout(alignment: .firstTextBaseline))
        : AnyLayout(VStackLayout(alignment: .leading, spacing: -80))
    }
    
    var body: some View {
        VStack {
            if !isCompact {
                Spacer()
            }
            
            altitudeText
                .padding(isCompact ? 20 : 0)
            
            if !isCompact {
                Spacer(minLength: 250)
            }
        }
        .frame(maxWidth: isCompact ? 350 : .infinity, maxHeight: isCompact ? 155 : .infinity)
        .background {
            RoundedRectangle(cornerRadius: 32)
                .fill(.customOrange)
                .ignoresSafeArea()
                .noiseEffect(opacity: 0.085)
        }
//        .overlay(alignment: .bottom) {
//            if !isCompact {
//                DetailsButton {
//                    withAnimation {
//                        isCompact = true
//                    }
//                }
//                .transition(.move(edge: .bottom).combined(with: .opacity))
//                
//            }
//        }
        .contentShape(.rect)
        .onTapGesture {
            if isCompact {
                withAnimation {
                    isCompact = false
                }
            }
        }
        .onChange(of: altitudeService.absoluteAltitude.displayValue) { old, new in
            guard old != new  else { return }
            
            withAnimation {
                altitude = new
            }
        }
    }
    
    private var altitudeText: some View {
        layout {
            Text("\(altitude)")
                .contentTransition(.numericText(value: Double(altitudeService.absoluteAltitude.displayValue)))
                .font(.custom("AkiLines", size: isCompact ? 150 : 360))
                .minimumScaleFactor(0.3)
                .lineLimit(1)
            
            Text(altitudeService.absoluteAltitude.formattedUnit(width: .wide))
                .font(.system(size: isCompact ? 70 : 100).weight(.ultraLight))
                .minimumScaleFactor(0.3)
                .lineLimit(1)
                
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(.offBlack)
    }
}

#Preview {
    @Previewable @State var isCompact = false
    @Previewable @State var service = AltitudeService()
    AltitudeView(service: service, isCompact: $isCompact)
}
