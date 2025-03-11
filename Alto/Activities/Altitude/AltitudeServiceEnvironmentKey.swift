//
//  AltitudeServiceEnvironmentKey.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 10/03/25.
//

import SwiftUI

struct AltitudeServiceEnvironmentKey: @preconcurrency EnvironmentKey {
    @MainActor static let defaultValue = AltitudeService()
}

extension EnvironmentValues {
    var altitudeService: AltitudeService {
        get { self[AltitudeServiceEnvironmentKey.self] }
        set { self[AltitudeServiceEnvironmentKey.self] = newValue }
    }
}
