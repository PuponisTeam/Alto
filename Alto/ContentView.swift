//
//  ContentView.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 05/03/25.
//

import CoreMotion
import SwiftUI

struct ContentView: View {
    @State private var altitude = 0
    
    var body: some View {
        ZStack {
            Color(.customOrange)
                .ignoresSafeArea()
                .noiseEffect(opacity: 0.085)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("\(altitude)")
                    .contentTransition(.numericText(value: Double(altitude)))
                    .font(.custom("AkiLines", size: 360))
                    .minimumScaleFactor(0.3)
                
                Text("meters")
                    .font(.system(size: 100).weight(.ultraLight))
                    .padding(.top, -75)
                    .padding(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.offBlack)
            .padding(.bottom, 300)
        }
        .onAppear(perform: setUpAltimiterUpdates)
    }
    
    private func setUpAltimiterUpdates() {
        let altimeter = CMAltimeter()
        
        altimeter.startAbsoluteAltitudeUpdates(to: .main) { data, error in
            guard let data else { return }
            
            withAnimation {
                altitude = Int(data.altitude.rounded())
            }
            
            print("Accuracy: \(data.accuracy), Precision: \(data.precision).")
        }
    }
}

#Preview {
    ContentView()
}
