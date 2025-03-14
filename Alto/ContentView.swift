//
//  ContentView.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 05/03/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showingDetails = false
    @State private var changedContainer = false
    @Environment(\.altitudeService) private var alitudeService
    
    @Namespace private var namespace
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: DetailsView.spacing) {
                AltitudeView(service: alitudeService, isCompact: $showingDetails)
                    .padding(showingDetails ? [.top, .horizontal] : [])
                    .padding(showingDetails ? [.horizontal] : [], 18)
                
                if showingDetails {
                    DetailsView()
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.altitudeService, AltitudeService())
}
