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
        guard !trackingAbsoluteAltitude else { return }
        
        altimeter.startAbsoluteAltitudeUpdates(to: .main) { [weak self] data, error in
            guard let self else {
                logger.error("'AltitudeService' instance not avaliable while trying to start absolute altitude updates.")
                return
            }
            
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
        guard trackingAbsoluteAltitude else { return }
        
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
