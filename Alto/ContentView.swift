//
//  ContentView.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 05/03/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showingDetails = false
    @State private var showModel3DView: Bool = false
    @State private var changedContainer = false
    @Environment(\.altitudeService) private var alitudeService
    
    @Namespace private var namespace
    
    var body: some View {
        if showModel3DView {
            Model3DView(showModel3DView: $showModel3DView)
        } else {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: DetailsView.spacing) {
                    AltitudeView(service: alitudeService, isCompact: $showingDetails)
                        .padding(showingDetails ? [.top, .horizontal] : [])
                        .padding(showingDetails ? [.horizontal] : [], 18)
                    
                    if showingDetails {
                        DetailsView(showModel3DView: $showModel3DView)
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.altitudeService, AltitudeService())
}
