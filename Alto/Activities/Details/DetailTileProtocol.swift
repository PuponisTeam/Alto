//
//  DetailTileProtocol.swift
//  Alto
//
//  Created by Alessio Garzia Marotta Brusco on 14/03/25.
//

import SwiftUI

protocol DetailTileProtocol: Identifiable {
    associatedtype BackgroundShapeStyle
    
    var id: UUID { get }
    var header: Label<Text, Image> { get }
    var backgroundStyle: BackgroundShapeStyle { get }
}
