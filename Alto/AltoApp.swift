//
//  AltoApp.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 05/03/25.
//

import OSLog
import SwiftUI

fileprivate let logger = Logger(subsystem: "Alto", category: "Alto App")

@main
struct AltoApp: App {
    @State private var altitudeService = AltitudeService()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.altitudeService, altitudeService)
                .onChange(of: scenePhase) {
                    switch scenePhase {
                    case .active:
                        altitudeService.startAbsoluteAltitudeUpdates()
                        altitudeService.startPressureUpdates()
                    case .background:
                        altitudeService.stopAbsoluteAltitudeUpdates()
                        altitudeService.startPressureUpdates()
                    default: break
                    }
                }
                .onAppear {
                    let values = altitudeService.avaliableValues()
                    
                    if !values.contains(.absoluteAltitude) {
                        logger.error("Absolute altitude tracking is not supported.")
                    } else if !values.contains(.pressure) {
                        logger.error("Pressure tracking is not supported.")
                    }
                }
        }
    }
}
