//
//  AltitudeService.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 10/03/25.
//

import CoreMotion
import Foundation
import OSLog

private let logger = Logger(subsystem: "Alto", category: "Altimeter Service")

@MainActor
@Observable
final class AltitudeService {
    private(set) var absoluteAltitude = 0.0
    private(set) var pressure = 0.0
    
    private(set) var trackingAbsoluteAltitude = false {
        didSet {
            if trackingAbsoluteAltitude {
                logger.info("Started absolute altitude updates.")
            } else {
                logger.info("Stopped absolute altitude updates.")
            }
        }
    }
    
    private let altimeter: CMAltimeter
    
    init() {
        altimeter = CMAltimeter()
    }
    
    func startAbsoluteAltitudeUpdates() {
        guard !trackingAbsoluteAltitude else {
            logger.warning("Tried to start absolute altitude updates while already tracking absolute altitude data.")
            return
        }
        
        altimeter.startAbsoluteAltitudeUpdates(to: .main) { [weak self] data, error in
            guard let self else { return }
            guard handleUpdateError(error) == false else { return }
            
            updateAltitude(with: data)
        }
        
        trackingAbsoluteAltitude = true
    }
    
    private func updateAltitude(with data: CMAbsoluteAltitudeData?) {
        guard let data else { return }
        absoluteAltitude = data.altitude
    }
    
    
    
    /// Logs eventual errors during altimeter updates. Called inside ´CMAltimiter.startAbsoluteAltitudeUpdates´ handler closure.
    /// - Parameter error: The error parameter given by the ´CMAltimiter.startAbsoluteAltitudeUpdates´ closure.
    /// - Returns: Boolean value representing if an error was indeed found.
    @discardableResult
    private func handleUpdateError(_ error: (any Error)?) -> Bool {
        guard let error else { return false }
        
        logger.error("Failed to update altitude. Error: \(error.localizedDescription).")
        return true
    }
    
    func stopAbsoluteAltitudeUpdates() {
        guard trackingAbsoluteAltitude else {
            logger.warning("Tried to stop absolute altitude updates without having started tracking altitude data.")
            
            return
        }
        
        altimeter.stopAbsoluteAltitudeUpdates()
        trackingAbsoluteAltitude = false
        
    }
    
    func authorizationStatus() -> CMAuthorizationStatus {
        CMAltimeter.authorizationStatus()
    }
    
    func isAvailable() -> Bool {
        CMAltimeter.isAbsoluteAltitudeAvailable()
    }
}


