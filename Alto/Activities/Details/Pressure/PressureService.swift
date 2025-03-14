//
//  PressureService.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 14/03/25.
//

import CoreMotion
import Foundation
import OSLog

private let logger = Logger(subsystem: "Alto", category: "Pressure Service")

@MainActor
@Observable
final class PressureService {
    private(set) var pressure = Measurement(value: 0, unit: UnitPressure.kilopascals)
    
    private(set) var trackingPressure = false {
        didSet {
            if trackingPressure {
                logger.info("Started pressure updates.")
            } else {
                logger.info("Stopped pressure updates.")
            }
        }
    }
    
    private let altimeter: CMAltimeter
    
    init() {
        altimeter = CMAltimeter()
    }
    
    func startAbsoluteAltitudeUpdates() {
        guard !trackingPressure else { return }
        
        altimeter.startAbsoluteAltitudeUpdates(to: .main) { [weak self] data, error in
            guard let self else {
                logger.error("'AltitudeService' instance not avaliable while trying to start absolute altitude updates.")
                return
            }
            
            guard handleUpdateError(error) == false else { return }
            updateAltitude(with: data)
        }
        
        trackingPressure = true
    }
    
    private func updateAltitude(with data: CMAbsoluteAltitudeData?) {
        guard let data else { return }
//        absoluteAltitude = .meters(data.altitude)
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
        guard trackingPressure else { return }
        
        altimeter.stopAbsoluteAltitudeUpdates()
        trackingPressure = false
    }
    
    func authorizationStatus() -> CMAuthorizationStatus {
        CMAltimeter.authorizationStatus()
    }
    
    func isAvailable() -> Bool {
        CMAltimeter.isRelativeAltitudeAvailable()
    }
}
