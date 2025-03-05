//
//  ContentView.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 05/03/25.
//

import CoreMotion
import SwiftUI

struct ContentView: View {
    @State private var altitude = 0.0
    
    var body: some View {
        Text("\(altitude) m")
            .task {
                let altimeter = CMAltimeter()
                print(CMAltimeter.isAbsoluteAltitudeAvailable())
                
                
                altimeter.startAbsoluteAltitudeUpdates(to: .main) { data, error in
                    guard let data else { return }
                    altitude = data.altitude
                    print("Accuracy: \(data.accuracy), Precision: \(data.precision).")
                }
            }
    }
}

#Preview {
    ContentView()
}
