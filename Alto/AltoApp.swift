//
//  AltoApp.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 05/03/25.
//

import SwiftUI

@main
struct AltoApp: App {
    @State private var altitudeService = AltitudeService()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.altitudeService, altitudeService)
                .onAppear(perform: altitudeService.startAbsoluteAltitudeUpdates)
                .onChange(of: scenePhase) {
                    if case .background = scenePhase {
                        altitudeService.stopAbsoluteAltitudeUpdates()
                    }
                }
        }
    }
}
