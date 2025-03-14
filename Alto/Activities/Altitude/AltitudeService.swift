//
//  AltitudeService.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 10/03/25.
//

import CoreMotion
import Foundation
import OSLog

private let logger = Logger(subsystem: "Alto", category: "Altitude Service")

@MainActor
@Observable
final class AltitudeService {
    enum TrackedValue: String {
        case absoluteAltitude = "altitude"
        case pressure = "pressure"
    }
    
    private(set) var absoluteAltitude = LocalizedLength(meters: 0)
    private(set) var pressure = Measurement(value: 0, unit: UnitPressure.hectopascals)
    
    private(set) var trackingAbsoluteAltitude = false {
        didSet {
            if trackingAbsoluteAltitude {
                logger.info("Started absolute altitude updates.")
            } else {
                logger.info("Stopped absolute altitude updates.")
            }
        }
    }
    
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
        guard !trackingAbsoluteAltitude else { return }
        
        altimeter.startAbsoluteAltitudeUpdates(to: .main) { [weak self] data, error in
            guard let self else {
                logger.error("'AltitudeService' instance not avaliable while trying to start absolute altitude updates.")
                return
            }
            
            guard handleUpdateError(error, tracking: .absoluteAltitude) == false else { return }
            updateAltitude(with: data)
        }
        
        trackingAbsoluteAltitude = true
    }
    
    private func updateAltitude(with data: CMAbsoluteAltitudeData?) {
        guard let data else {
            logger.error("Found nil value trying to update absolute altitude data.")
            return
        }
        
        absoluteAltitude = .meters(data.altitude)
    }
    
    func stopAbsoluteAltitudeUpdates() {
        guard trackingAbsoluteAltitude else { return }
        
        altimeter.stopAbsoluteAltitudeUpdates()
        trackingAbsoluteAltitude = false
    }
    
    func startPressureUpdates() {
        guard !trackingPressure else { return }
        
        altimeter.startRelativeAltitudeUpdates(to: .main) { [weak self] data, error in
            guard let self else {
                logger.error("'AltitudeService' instance not avaliable while trying to start pressure updates.")
                return
            }
            
            guard handleUpdateError(error, tracking: .pressure) == false else { return }
            updatePressure(with: data)
            
        }
    }
    
    private func updatePressure(with data: CMAltitudeData?) {
        guard let data else {
            logger.error("Found nil value trying to update pressure data.")
            return
        }
        
        pressure.value = data.pressure.doubleValue
    }
    
    func stopPressureUpdates() {
        guard !trackingPressure else { return }
        
        altimeter.stopRelativeAltitudeUpdates()
        trackingPressure = false
    }
    
    /// Logs eventual errors during altimeter updates. Called inside ´CMAltimiter.startAbsoluteAltitudeUpdates´  and ´CMAltimiter.startRelativeAltitudeUpdates´  handler closures.
    /// - Parameters:
    ///   - error: The error parameter given by the updates closure.
    ///   - value: The value that was being tracked while handling the error.
    /// - Returns: Boolean value representing if an error was indeed found.
    @discardableResult
    private func handleUpdateError(_ error: (any Error)?, tracking value: TrackedValue) -> Bool {
        guard let error else { return false }
        
        logger.error("Failed to update \(value.rawValue). Error: \(error.localizedDescription).")
        return true
    }
    
    func authorizationStatus() -> CMAuthorizationStatus {
        CMAltimeter.authorizationStatus()
    }
    
    func avaliableValues() -> [TrackedValue] {
        switch (CMAltimeter.isAbsoluteAltitudeAvailable(), CMAltimeter.isRelativeAltitudeAvailable()) {
        case (true, true):
            return [.absoluteAltitude, .pressure]
        case (true, false):
            return [.absoluteAltitude]
        case (false, true):
            return [.pressure]
        default:
            return []
        }
    }
}
