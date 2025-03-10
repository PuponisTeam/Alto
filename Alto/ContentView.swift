//
//  ContentView.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 05/03/25.
//

import CoreMotion
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.customOrange)
                .ignoresSafeArea()
                .noiseEffect(opacity: 0.085)
            
            AltitudeView()
                .padding(.bottom, 300)
        }
    }
}

#Preview {
    ContentView()
}
