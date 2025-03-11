//
//  LocalizedLength.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 11/03/25.
//

import OSLog
import Foundation

fileprivate let logger = Logger(subsystem: "Alto", category: "Localized Length")

struct LocalizedLength: Equatable {
    private var metersMeasurement: Measurement<UnitLength>
    
    private var feetMeasurement: Measurement<UnitLength> {
        metersMeasurement.converted(to: .feet)
    }
    
    private var mesurament: Measurement<UnitLength> {
        Locale.autoupdatingCurrent.measurementSystem == .metric ? metersMeasurement : feetMeasurement
    }
    
    var value: Double {
        mesurament.value
    }
    
    var displayValue: Int {
        Int(value.rounded())
    }
    
    var unit: UnitLength {
        mesurament.unit
    }
    
    init(meters: Double) {
        metersMeasurement = Measurement(value: meters, unit: .meters)
    }
    
    // Tremendo but funziona.
    func formattedUnit(
        width: Measurement<UnitLength>.FormatStyle.UnitWidth
    ) -> String {
        var measurementCopy = mesurament
        measurementCopy.value = Double(displayValue)
        let string = measurementCopy.formatted(.measurement(width: width, usage: .asProvided))
        
        do {
            let regex = try Regex("\\d+ ")
            return string.replacing(regex, with: "")
        } catch {
            logger.error("Failed to create regex while formatting unit. Error: \(error)")
            return string
        }
    }
    
    static func meters(_ meters: Double) -> LocalizedLength {
        LocalizedLength(meters: meters)
    }
    
    static func digitConverted(_ value: Double) -> Int {
        Int(value.rounded())
    }
}
