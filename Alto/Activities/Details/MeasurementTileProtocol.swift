//
//  MeasurementTileProtocol.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 14/03/25.
//

import Foundation

protocol MeasurementTileProtocol: DetailTileProtocol {
    associatedtype ForegroundShapeStyle
    
    var measurement: Measurement<Unit> { get }
    
    var value: Double { get }
    func formattedString() -> String
    
    var foregroundStyle: ForegroundShapeStyle { get }
}
