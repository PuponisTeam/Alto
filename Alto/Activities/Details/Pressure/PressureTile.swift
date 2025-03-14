//
//  PressureTile.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 14/03/25.
//

import SwiftUI

struct PressureTile: MeasurementTileProtocol {
    let id: UUID
    let header: Label<Text, Image>
    let backgroundStyle = Color.black
    let foregroundStyle = Color.white
    
    private(set) var measurement: Measurement<Unit>
    
    var value: Double {
        measurement.value
    }
    
    func formattedString() -> String {
        ""
    }
}
