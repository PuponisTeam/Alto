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
    
    @Namespace private var namespace
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                AltitudeView(isCompact: $showingDetails)
                    .padding(showingDetails ? 20 : 0)
                
                if showingDetails {
                    // DetailsView
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
